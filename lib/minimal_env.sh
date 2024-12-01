function minimal_env(){
  if [[ -f /etc/os-release ]]; then ource /etc/os-release; fi
  # always full env in archlinux
  if [[ "$ID" == "arch" ]]; then return 1; fi
  if [[ "$(whoami)" == "root" ]]; then return 0; fi
  if command -v termux-setup-storage; then return 0; fi
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    return 0
    # many other tests omitted
  else
    case $(ps -o comm= -p "$PPID") in
      sshd|*/sshd) return 0;;
    esac
  fi
  return 1
}
