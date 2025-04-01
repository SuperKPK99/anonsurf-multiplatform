import strformat
import .. / commons / ansurf_objects


proc cli_send_msg*(title, body: string, code: StatusImg) =
  #[
    Print message to CLI
    0: Ok
    1. Warn
    2. Error
  ]#
  const
    B_MAGENTA = "\e[95m"
    B_GREEN = "\e[92m"
    B_RED = "\e[91m"
    B_CYAN = "\e[96m"
    B_BLUE = "\e[94m"
    RESET = "\e[0m"

  case code
  of SecurityHigh:
    echo fmt"[{B_GREEN}*{RESET}] {title}"
    echo fmt"{B_GREEN}{body}{RESET}"
  of SecurityMedium:
    echo fmt"[{B_MAGENTA}!{RESET}] {title}"
    echo fmt"{B_BLUE}{body}{RESET}"
  of SecurityLow:
    echo fmt"[{B_RED}x{RESET}] {title}"
    echo fmt"{B_CYAN}{body}{RESET}"
  of SecurityInfo:
    echo fmt"[{B_BLUE}+{RESET}] {title}"
    echo fmt"{B_BLUE}{body}{RESET}"


# Dummy implementation for GUI notifications - does nothing but forwards to CLI
proc gtk_send_msg*(title, body: string, code: StatusImg) =
  cli_send_msg(title, body, code)
