function sssh() {
  local server
  server=$(grep -E '^Host ' ~/.ssh/config | grep -v '*' | tr ',' ' ' | awk '{$1=""; print $0}' | tr ' ' '\n' | sed '/^$/d' |  fzf)
  if [[ -n "$server" ]]; then
    ssh "$server"
  fi
}

sssh
