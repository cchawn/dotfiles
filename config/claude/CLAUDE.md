# CLAUDE.md

## Tools & Environment

- Use `gh` CLI for interacting with GitHub (authenticated access)
- Detect package manager: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `package-lock.json` → npm
- Check dependency files before assuming library availability
- Prefer simple git commands without `-C` flag when already in the working directory.
- Use `sentry-cli` skill for Sentry issues (URLs like `*.sentry.io/issues/*`)
- Use `jira-cli` skill for Jira tickets (URLs like `*.atlassian.net/browse/*`)
- Use subagents and worktrees liberally to keep main conversation focused
- Offload research, exploration, and parallel work to subagents
- One task per subagent for focus
- Use a subagent to review plans as a staff engineer before implementation

## Style

- Canadian spelling in docs/commits, American in code
- Avoid "robust", "thorough", "comprehensive"
- Prefer evergreen language, never use terms like "new", "improved", or "enhanced"
- Never comment out code, delete it instead
- When modifying documentation (README, configs), preserve existing formatting choices like emojis, headers, and styling unless explicitly asked to change them

## Workflow

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- Write detailed specs upfront to reduce ambiguity
- Track tasks in `tasks/todo.md` with checkable items; mark complete as you go
- After ANY correction from the user: update `tasks/lessons.md` with the pattern
- Review lessons at session start for relevant project
- When given a bug report: just fix it autonomously - identify logs, errors, failing tests, then resolve
- When I interrupt or say "no", stop immediately and ask what approach I'd prefer before continuing

## Code Changes

- Avoid over-engineering. Only make changes that are directly requested or clearly necessary. Keep solutions simple and focused.
- Explore codebase for reusable functions before implementing - avoid duplication
- Examine patterns in neighbouring files first
- Check linting configs (`.eslintrc`, `.rubocop.yml`, `.editorconfig`) and follow them
- Code style priority: (1) Consistency with file, (2) Readability, (3) Performance, (4) Concise
- Stop and confirm before: architectural changes, multiple valid approaches, shared code/API changes, rewrites
- Preserve existing comments unless provably false
- Go light on comments in new code - code should be self-explanatory; only comment non-obvious "why"
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky, step back and implement the elegant solution
- Check for duplicated code patterns; extract to shared locations

## Testing & Verification

- Never mock the functionality being tested
- Never write tests that only test mocked behaviour
- Test output must be clean (no ignored warnings/errors)
- Never mark a task complete without proving it works
- Diff behaviour between main and your changes when relevant
- Run tests, check logs, demonstrate correctness
- Show explicit proof of completion (command output, test results) before claiming success

## Best Practices

- Before guessing file paths or URLs, search config files or use Glob/Grep to find the actual locations

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
