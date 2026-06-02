#!/usr/bin/env sh
set -eu

tmp="$(mktemp)"

{
  printf '[\n'
  first=1

  find diario -type f -name '*.md' | sort | while IFS= read -r file; do
    case "$file" in
      diario/[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]/*.md) ;;
      *) continue ;;
    esac

    if [ "$first" -eq 0 ]; then
      printf ',\n'
    fi

    first=0
    printf '  "%s"' "$file"
  done
  printf '\n]\n'
} > "$tmp"

mv "$tmp" diario/entradas.json
