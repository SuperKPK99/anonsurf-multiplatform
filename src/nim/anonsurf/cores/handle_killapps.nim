import .. / cli / ansurf_cli_killapps
import commons / ansurf_objects


proc init_cli_askkill*(is_desktop: bool): callback_kill_apps =
  # Always use CLI version regardless of desktop environment
  return cli_kill_apps
