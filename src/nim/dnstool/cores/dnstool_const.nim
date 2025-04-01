import os

# Detect OS when compiling
const
  os_id = staticExec("grep '^ID=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '\"'")
  os_id_like = staticExec("grep '^ID_LIKE=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '\"'")

# Common paths across all distributions
const
  system_dns_file* = "/etc/resolv.conf"
  system_dns_backup* = "/etc/resolv.conf.bak"
  resolvconf_dns_file* = "/run/resolvconf/resolv.conf"
  dhclient_dns_file* = "/var/lib/dhcp/dhclient.leases"
  resolvconf_tail_file* = "/etc/resolvconf/resolv.conf.d/tail"
  dhclient_binary* = "/usr/sbin/dhclient"
  
  # DHCP hooks
  hook_script_dhcp_path* = "/etc/dhcp/dhclient-enter-hooks.d/dnstool"
  hook_script_dhcp_data* = "make_resolv_conf() { :; }"
  
  # NetworkManager hooks
  hook_script_nm_path* = "/etc/NetworkManager/conf.d/90-dns-none.conf"
  hook_script_nm_data* = "[main]\ndns=none\n"
  
  # Custom paths for different distributions
  systemd_resolved_conf* = "/etc/systemd/resolved.conf.d/anonsurf.conf"
  systemd_resolved_conf_data* = "[Resolve]\nDNS=127.0.0.1\nDNSSEC=false\n"

type
  AddrFromParams* = object
    has_dhcp_flag*: bool
    list_addr*: seq[string] 