import os
import dnstool_const
import .. / cli / [print, help]
import utils

# Forward declarations for functions in other modules
proc resolvconf_exists*(): bool
proc resolvconf_create_symlink*(): bool
proc dhclient_binary_exists*(): bool
proc dhclient_create_dhcp_dns*()
proc dhclient_parse_dns*(): seq[string]
proc write_dns_to_resolvconf_tail*(list_addr: seq[string])
proc hook_script_init*()
proc hook_script_finit*()


proc handle_create_resolvconf_symlink() =
  if not tryRemoveFile(system_dns_file):
    print_error("Failed to remove " & system_dns_file & " to create a new one")
  else:
    discard resolvconf_create_symlink()


proc handle_addr_dhcp_only() =
  # Detect which resolver system is in use
  let
    is_systemd_resolved = fileExists("/run/systemd/resolve/resolv.conf")
    is_resolvconf = resolvconf_exists()
    is_dhclient = dhclient_binary_exists()
    is_networkmanager = fileExists("/etc/NetworkManager/NetworkManager.conf")
  
  if is_systemd_resolved:
    # For systems using systemd-resolved
    discard execShellCmd("ln -sf /run/systemd/resolve/resolv.conf " & system_dns_file)
    # Remove any systemd-resolved configuration that might override things
    if fileExists(systemd_resolved_conf):
      discard tryRemoveFile(systemd_resolved_conf)
    # Restart systemd-resolved
    discard execShellCmd("systemctl restart systemd-resolved")
  elif is_resolvconf:
    # For systems using resolvconf
    handle_create_resolvconf_symlink()
  elif is_dhclient:
    # For systems using dhclient
    dhclient_create_dhcp_dns()
  elif is_networkmanager:
    # For systems using NetworkManager
    discard execShellCmd("rm -f " & hook_script_nm_path) # Remove any hook preventing DNS
    discard execShellCmd("systemctl restart NetworkManager")
  else:
    print_error("Can't find a supported resolver system. Try manually restarting network services.")


proc handle_addr_custom_only(list_addr: seq[string]) =
  if not tryRemoveFile(system_dns_file):
    print_error("Failed to remove " & system_dns_file & " to create new one.")
  write_dns_to_system(list_addr)


proc handle_addr_mix_with_dhcp(list_addr: seq[string]) =
  # Detect which resolver system is in use
  let
    is_systemd_resolved = fileExists("/run/systemd/resolve/resolv.conf")
    is_resolvconf = resolvconf_exists()
    is_dhclient = dhclient_binary_exists()
  
  if is_systemd_resolved:
    # For systemd-resolved, we create a static config with both custom and DHCP DNS
    discard existsOrCreateDir("/etc/systemd/resolved.conf.d")
    var dns_list = list_addr.join(" ")
    let config_content = "[Resolve]\nDNS=" & dns_list & "\nDNSSEC=false\n"
    writeFile(systemd_resolved_conf, config_content)
    discard execShellCmd("systemctl restart systemd-resolved")
  elif is_resolvconf:
    # For resolvconf systems
    handle_create_resolvconf_symlink()
    write_dns_to_resolvconf_tail(list_addr)
  elif is_dhclient:
    # For dhclient systems
    var list_combo_addr = list_addr
    list_combo_addr.add(dhclient_parse_dns())
    write_dns_to_system(list_combo_addr)
  else:
    print_error("No supported resolver system found. Using custom addresses only.")
    handle_addr_custom_only(list_addr)


proc dnst_show_status*() =
  if not system_resolvconf_exists():
    print_error_resolv_not_found()
    return

  check_system_dns_is_static()

  let
    addresses = parse_dns_addresses()

  if len(addresses) == 0:
    print_error_resolv_empty()
  elif anonsurf_is_running():
    if has_only_localhost(addresses):
      print_under_tor_dns()
    else:
      print_error_dns_leak()
  else:
    if has_only_localhost(addresses):
      print_error_local_host()
    else:
      print_dns_addresses(addresses)


proc handle_create_backup*() =
  if not system_resolvconf_exists():
    print_error("Skip creating backup file. Missing " & system_dns_file)
    return

  if system_has_only_localhost():
    print_error("Skip creating backup file. System has only localhost.")
    return

  if fileExists(system_dns_backup):
    if not tryRemoveFile(system_dns_backup):
      print_error("Failed to remove " & system_dns_backup & " to create new one.")

  if not system_dns_file_is_symlink():
    # If /etc/resolv.conf is not a symlink, create a backup
    create_backup()
  else:
    # If it's a symlink (like with resolved or resolvconf)
    # Create backup of the configuration anyway
    create_backup()


proc handle_restore_backup*() =
  # Restore /etc/resolv.conf.bak to /etc/resolv.conf
  if fileExists(system_dns_backup):
    do_restore_backup()
  elif not system_resolvconf_exists() or system_has_only_localhost_or_empty_dns():
    # If the backup file doesn't exist and we need to restore DNS
    handle_addr_dhcp_only()

  dnst_show_status()


proc handle_argv_missing*() =
  dnst_show_help()
  dnst_show_status()


proc handle_create_dns_addr*(has_dhcp: bool, list_addr: seq[string]) =
  var
    keep_hook_script = true
    
  if not has_dhcp:
    handle_addr_custom_only(list_addr)
  else:
    if len(list_addr) == 0:
      keep_hook_script = false
      handle_addr_dhcp_only()
    else:
      handle_addr_mix_with_dhcp(list_addr)

  # For systems that need hook scripts to prevent DNS overwriting
  let is_systemd_resolved = fileExists("/run/systemd/resolve/resolv.conf")
  
  if is_systemd_resolved or resolvconf_exists() or not keep_hook_script:
    hook_script_finit()
  else:
    hook_script_init()
    
  dnst_show_status() 