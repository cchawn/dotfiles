#!/usr/bin/env bash
# settings.json is generated, so work-only auto-mode rules stay out of this public repo.
#   build: settings.base.json (tracked) + private/claude-automode.json (gitignored) -> settings.json
#   save:  settings.json -> settings.base.json (everything but autoMode) + private/claude-automode.json (autoMode)
# Run `save` after Claude Code or you change settings.json, then commit settings.base.json.

set -euo pipefail

claude_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
base="$claude_dir/settings.base.json"
private="$claude_dir/../private/claude-automode.json"
live="$claude_dir/settings.json"

build() {
  if [[ -f "$live" ]] && ! diff -q <(jq -S 'del(.autoMode)' "$live") <(jq -S . "$base") > /dev/null; then
    echo "settings.json has changes that aren't in settings.base.json. Run '$0 save' first." >&2
    exit 1
  fi
  local tmp
  tmp="$(mktemp)"
  if [[ -f "$private" ]]; then
    jq -s '.[0] * .[1]' "$base" "$private" > "$tmp"
  else
    jq . "$base" > "$tmp"
  fi
  mv "$tmp" "$live"
  echo "Built $live"
}

save() {
  jq 'del(.autoMode)' "$live" > "$base.tmp" && mv "$base.tmp" "$base"
  if jq -e 'has("autoMode")' "$live" > /dev/null; then
    mkdir -p "$(dirname "$private")"
    jq '{autoMode}' "$live" > "$private.tmp" && mv "$private.tmp" "$private"
  fi
  echo "Saved $base and $private"
}

case "${1:-}" in
  build) build ;;
  save) save ;;
  *)
    echo "Usage: $0 build|save" >&2
    exit 2
    ;;
esac
