function is_ssh_session_or_root(){
  if [[ "$(whoami)" == "root" ]]; then return 0; fi
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
