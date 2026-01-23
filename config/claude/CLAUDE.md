# CLAUDE.md

## Tools & Environment

- Use `gh` CLI for interacting with GitHub (authenticated access)
- Detect package manager: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `package-lock.json` → npm
- Check dependency files before assuming library availability
- Prefer simple git commands without `-C` flag when already in the working directory.

## Style

- Canadian spelling in docs/commits, American in code
- Avoid "robust", "thorough", "comprehensive"
- Prefer evergreen language, never use terms like "new", "improved", or "enhanced"
- Never comment out code, delete it instead

## Code Changes

- Examine patterns in neighbouring files first
- Check linting configs (`.eslintrc`, `.rubocop.yml`, `.editorconfig`) and follow them
- Code style priority: (1) Consistency with file, (2) Readability, (3) Performance, (4) Concise
- Stop and confirm before: architectural changes, multiple valid approaches, shared code/API changes, rewrites
- Preserve existing comments unless provably false
- Go light on comments in new code - code should be self-explanatory; only comment non-obvious "why"

## Testing

- Never mock the functionality being tested
- Never write tests that only test mocked behaviour
- Test output must be clean (no ignored warnings/errors)

## Git

- Semantic commits: `fix:`, `feat:`, `chore:` prefix, under 80 chars
- Use `--force-with-lease` not `--force`
- Never add AI as coauthor

### Work vs Personal Repositories

Check `git remote get-url origin`:
- **Work**: URL does NOT contain "cchawn"
- **Personal**: URL contains "cchawn"

## Forbidden

- `--no-verify` to bypass hooks
- Direct commits to main/master
- Rewriting pushed history without coordination
- Changes unrelated to assigned task
- Committing secrets or credentials
- Claiming certainty when uncertain - admit knowledge gaps explicitly
