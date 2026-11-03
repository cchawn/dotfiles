# CLAUDE.md

## Tools & Environment

- Before drafting recurring artifacts (weekly updates, status posts, reviews), check skills, plugins, and MCP servers; only go freehand if none fit
- Use the `gh-pr` skill to open PRs or rewrite PR descriptions
- Use `betting:write-update` for weekly bet updates
- Jira: MCP locker. Google Docs and Slack: MCP locker or Glean, try both before saying you can't read it. Notion (`notion.so`, `app.notion.com`): Notion MCP
- Stacked PRs: `gh stack`, not `gh pr create --base`
- Work in local clones under `~/Workspace`, not through `gh api` or remote agents
- Don't prefix commands with `cd <current dir> &&` or use `git -C` when already in the directory
- `jq` for JSON and `yamllint` for YAML, not Python
- Commands that prompt for passwords or need 1Password (`op`): give me the command to run with `!`, then verify the result yourself

## Style

- Write plainly so a non-specialist can follow. No mannered prose, jargon, buzzwords, or intensifiers ("robust", "comprehensive", "load-bearing", "blast radius", "critical path")
- Define a term or acronym the first time it appears
- Keep artifacts short; put detailed evidence in the chat reply
- Canadian spelling in docs and commits, American in code
- Evergreen language: never "new", "improved", or "enhanced"
- When editing docs, keep their existing formatting (emojis, headers, styling)

## Workflow

- If I ask a question or for a ticket update, do only that; don't start coding
- Bug report: find the logs, errors, or failing tests and fix it
- Plan mode before architectural decisions or work spanning multiple files or PRs; bug fixes with a clear cause skip it
- Summarize what investigation found before implementing multi-step work
- Multi-PR work: write a stack plan first (PR boundaries, scope, dependencies, rollback)
- Check docs, code, and configs before guessing about external APIs, network behaviour, or CI failures

## Scope Discipline

- Fix only what was asked, no drive-by refactors, upgrades, or cleanup
- When fixing deployed config (e.g. TLD migrations), leave local dev config alone unless I confirm
- Stop and confirm when there are several valid approaches, or before changing shared code or APIs or rewriting a file

## Code Changes

- Priority: consistency with the file, readability, performance, concision
- Don't add code comments unless asked; code should explain itself
- Delete code, never comment it out
- Small, focused PRs; split large changes into stacked PRs that can roll back independently
- Database migrations get their own PR

## PR Reviews

- Verify every concern against the full file, not just the diff: grep related usages and quote lines. Drop anything you can't verify
- Draft inline comments in my voice (short, direct, no hedging)
- Never post or reply to GitHub comments for me; ask before Request Changes

## Testing & Verification

- Never mock the thing under test, or write tests that only exercise mocks
- No tests for trivial config (allowlist or ignore-list entries); run the existing suite instead
- Test output must be clean, no ignored warnings or errors
- Show proof (command output, test results) before calling a task done

## Git

- Semantic commits (`fix:`, `feat:`, `chore:`), under 80 characters
- Never commit to main/master, use `--no-verify`, or commit secrets
- Address review feedback in a new commit, never an amend. If I ask for an amend, check `git log -1` for bot commits first
- Before force-pushing, `git fetch` and check for upstream commits; use `--force-with-lease`. Ask before rewriting pushed history
- When rebasing stacks, check upstream refs so squash-merged commits aren't dropped
- 1Password/GPG signing fails sometimes; retry once

### Work vs Personal Repositories

Check `git remote get-url origin`:

- **Work**: URL does NOT contain "cchawn"
- **Personal**: URL contains "cchawn"
