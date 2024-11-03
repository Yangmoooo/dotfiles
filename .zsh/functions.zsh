addz ()
{
  if [[ -f "$1" ]]; then
    echo -n -e "\x00" >> "$1"
    echo "Added a byte to the file: $1"
  else
    echo "File not found: $1"
  fi
}

yz ()
{
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
