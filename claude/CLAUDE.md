# CLAUDE.md

## Tools & Environment

- Use `gh` CLI for GitHub (authenticated access)
- Use `sentry-cli` skill for Sentry issues (`*.sentry.io/issues/*`)
- Use `jira-cli` skill for Jira tickets (`*.atlassian.net/browse/*`)
- Use `gh-pr` skill when creating pull requests on GitHub
- Use Notion MCP for Notion documents (`*.notion.so/*`)
- Detect JS/TS package manager: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `package-lock.json` → npm, `deno.lock` → deno
- Prefer simple git commands without `-C` flag when already in the working directory
- Primary languages and ecosystems: TypeScript, Ruby, YAML (Helm/K8s)
- Use `jq` for JSON processing in Bash, not Python
- Use `yamllint` for YAML validation in Bash, not Python

## Style

- Canadian spelling in docs/commits, American in code
- Avoid "robust", "thorough", "comprehensive"
- Prefer evergreen language, never use "new", "improved", or "enhanced"
- Never comment out code, delete it instead
- When modifying documentation, preserve existing formatting choices (emojis, headers, styling)

## Workflow

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- Break work into phases: Phase 1: investigation → Phase 2: implementation → Phase 3: commit and PR. Summarize after each phase.
- When given a bug report: fix it autonomously — identify logs, errors, failing tests, then resolve

## Code Changes

- Code style priority: (1) Consistency with file, (2) Readability, (3) Performance, (4) Concise
- Stop and confirm before: architectural changes, multiple valid approaches, shared code/API changes, full rewrites

## Testing & Verification

- Never mock the functionality being tested
- Never write tests that only test mocked behaviour
- Test output must be clean (no ignored warnings/errors)
- IMPORTANT: Never mark a task complete without proving it works — show explicit proof of completion (command output, test results)

## Git

- Use semantic commits: `fix:`, `feat:`, `chore:` prefix, keep the message under 80 chars
- Use `--force-with-lease`, never `--force`
- Never add AI as coauthor
- 1Password/GPG signing may cause transient commit failures — retry once if signing fails

### Work vs Personal Repositories

Check `git remote get-url origin`:

- **Work**: URL does NOT contain "cchawn"
- **Personal**: URL contains "cchawn"

## IMPORTANT: Forbidden Actions

- Never use `--no-verify` to bypass hooks
- Never commit directly to main/master
- Never rewrite pushed history without coordination
- Never make changes unrelated to assigned task
- Never commit secrets or credentials
- Never reply to comments in GitHub on my behalf
