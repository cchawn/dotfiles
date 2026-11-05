# CLAUDE.md

Personal macOS dotfiles. `install.sh` symlinks each config into place (`claude/` to `~/.claude`, `zsh/.zshrc` to `~/.zshrc`, and so on), so edits here take effect immediately.

## Gotchas

- `claude/` is the live `~/.claude`. Only `CLAUDE.md`, `settings.base.json`, `settings.sh`, `statusline.sh`, `skills/`, `commands/`, and `hooks/` are tracked; the rest is Claude Code runtime state. `hooks/herdr-*` is managed by herdr and ignored.
- `claude/settings.json` is generated and ignored: `claude/settings.sh build` merges `settings.base.json` with the work-only `autoMode` block in `private/claude-automode.json`. After you or Claude Code change `settings.json`, run `claude/settings.sh save` and commit `settings.base.json`. Never put `autoMode` in a tracked file.
- `private/` is gitignored and holds work settings and git identity. Don't copy anything from it into tracked files.
- Add Homebrew dependencies to `Brewfile`.

## Checks

No build or test suite. Validate edits with:

- `jq . <file>.json` (not `zed/settings.json`, which has comments)
- `zsh -n zsh/.zshrc`
- `shellcheck <script>.sh`
