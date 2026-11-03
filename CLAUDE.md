# CLAUDE.md

Personal macOS dotfiles. `install.sh` symlinks each config into place (`claude/` to `~/.claude`, `zsh/.zshrc` to `~/.zshrc`, and so on), so edits here take effect immediately.

## Gotchas

- `claude/` is the live `~/.claude`. Only `CLAUDE.md`, `settings.json`, `statusline.sh`, `skills/`, `commands/`, and `hooks/` are tracked; the rest is Claude Code runtime state. `hooks/herdr-*` is managed by herdr and ignored.
- `private/` is gitignored and holds work settings and git identity. Don't copy anything from it into tracked files.
- Add Homebrew dependencies to `Brewfile`.

## Checks

No build or test suite. Validate edits with:

- `jq . <file>.json` (not `zed/settings.json`, which has comments)
- `zsh -n zsh/.zshrc`
- `shellcheck <script>.sh`
