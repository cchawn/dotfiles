# CLAUDE.md

## Tools & Environment

- Use `gh` CLI for interacting with GitHub (authenticated access)
- When working with MCP tools (Datadog, Notion, Jira, etc.), use the MCP tool directly instead of falling back to Bash/curl. Check available MCP tools before attempting HTTP requests or CLI workarounds.
- Use `sentry-cli` skill for Sentry issues (URLs like `*.sentry.io/issues/*`)
- Use `jira-cli` skill for Jira tickets (URLs like `*.atlassian.net/browse/*`)
- Use Notion MCP for interacting with Notion documents (URLs like `*.notion.so/*`)
- Detect package manager: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `package-lock.json` → npm, `deno.lock` → deno
- Check dependency files before assuming library availability
- Prefer simple git commands without `-C` flag when already in the working directory
- Use subagents and worktrees liberally to keep main conversation focused
- Offload research, exploration, and parallel work to subagents
- One task per subagent for focus
- Use a subagent to review plans as a staff engineer before implementation
- Primary languages and ecosystems: TypeScript, Ruby, YAML (Helm/K8s)
- Use `jq` for JSON processing in Bash, not Python

## General Principles

- Before making any changes or suggesting an approach, first: 1) Check what tools/MCPs are available, 2) Read relevant config files to understand current patterns, 3) Briefly state your plan and wait for confirmation on non-trivial changes.
- Do not guess URLs, paths, or configurations — use Glob/Grep to find actual locations.
- Do not remove, rename, or change content that wasn't explicitly requested. Keep changes scoped to exactly what was asked.

## Style

- Canadian spelling in docs/commits, American in code
- Avoid "robust", "thorough", "comprehensive"
- Prefer evergreen language, never use terms like "new", "improved", or "enhanced"
- Never comment out code, delete it instead
- When modifying documentation (README, configs), preserve existing formatting choices like emojis, headers, and styling unless explicitly asked to change them

## Workflow

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- Break work into phases and complete each one before moving to the next. After each phase, summarize what was done and what's remaining. Phase 1: investigation. Phase 2: implementation. Phase 3: commit and PR.
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
- When editing files, integrate content into the existing structure rather than appending at the end. Match the style, organization, and formatting of the existing document.
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

## Git

- Semantic commits: `fix:`, `feat:`, `chore:` prefix, under 80 chars
- Use `--force-with-lease` not `--force`
- Never add AI as coauthor
- 1Password/GPG signing may cause transient commit failures — retry once if signing fails

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
