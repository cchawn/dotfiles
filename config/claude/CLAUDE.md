# CLAUDE.md

## Tools & Environment

- Use `gh` CLI for GitHub (authenticated access)
- Use MCP tools directly for Datadog, Notion, Jira — don't fall back to Bash/curl
- Use `sentry-cli` skill for Sentry issues (`*.sentry.io/issues/*`)
- Use `jira-cli` skill for Jira tickets (`*.atlassian.net/browse/*`)
- Use Notion MCP for Notion documents (`*.notion.so/*`)
- Detect package manager: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `package-lock.json` → npm, `deno.lock` → deno
- Prefer simple git commands without `-C` flag when already in the working directory
- Use subagents and worktrees liberally to keep main conversation focused
- Offload research, exploration, and parallel work to subagents — one task per subagent
- Use a subagent to review plans as a staff engineer before implementation
- Primary languages and ecosystems: TypeScript, Ruby, YAML (Helm/K8s)
- Use `jq` for JSON processing in Bash, not Python

## General Principles

- Before making changes: 1) Check available tools/MCPs, 2) Read relevant config files, 3) State plan and wait for confirmation on non-trivial changes
- IMPORTANT: When I interrupt or say "no", stop immediately and ask what approach I'd prefer

## Style

- Canadian spelling in docs/commits, American in code
- Avoid "robust", "thorough", "comprehensive"
- Prefer evergreen language, never use "new", "improved", or "enhanced"
- Never comment out code, delete it instead
- When modifying documentation, preserve existing formatting choices (emojis, headers, styling) unless explicitly asked to change

## Workflow

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- Break work into phases: Phase 1: investigation → Phase 2: implementation → Phase 3: commit and PR. Summarize after each phase.
- Write detailed specs upfront to reduce ambiguity
- Track tasks in `tasks/todo.md` with checkable items; mark complete as you go
- After ANY correction from me: update `tasks/lessons.md` with the pattern
- Review lessons at session start for relevant project
- When given a bug report: fix it autonomously — identify logs, errors, failing tests, then resolve

<!-- TODO: bug report handling and phase-based workflow could become skills (loaded on-demand instead of every session) -->

## Code Changes

- Code style priority: (1) Consistency with file, (2) Readability, (3) Performance, (4) Concise
- Stop and confirm before: architectural changes, multiple valid approaches, shared code/API changes, rewrites

## Testing & Verification

- Never mock the functionality being tested
- Never write tests that only test mocked behaviour
- Test output must be clean (no ignored warnings/errors)
- IMPORTANT: Never mark a task complete without proving it works — show explicit proof of completion (command output, test results)
- Diff behaviour between main and your changes when relevant

## Git

- Semantic commits: `fix:`, `feat:`, `chore:` prefix, under 80 chars
- Use `--force-with-lease` not `--force`
- Never add AI as coauthor
- 1Password/GPG signing may cause transient commit failures — retry once if signing fails

### Work vs Personal Repositories

Check `git remote get-url origin`:

- **Work**: URL does NOT contain "cchawn"
- **Personal**: URL contains "cchawn"

## IMPORTANT: Forbidden

- `--no-verify` to bypass hooks
- Direct commits to main/master
- Rewriting pushed history without coordination
- Changes unrelated to assigned task
- Committing secrets or credentials
