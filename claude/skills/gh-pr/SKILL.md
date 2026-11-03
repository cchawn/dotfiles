---
name: gh-pr
description: Opens or updates GitHub pull requests with the gh CLI. Covers pre-flight checks, pushing, a draft PR with a short body, stacked PRs with gh stack, and watching CI in the background to fix failures. Use when opening, submitting, or rewriting the description of a pull request.
---

# GitHub Pull Request (`gh pr create`)

## Pre-flight Checks

- If `git branch --show-current` is `main` or `master`, stop and tell the user.
- Push commits the remote branch lacks (`-u` if no upstream is set).
- If the branch already has a PR (`gh pr view --json url`), update it with `gh pr edit --body-file` instead of opening another.

## PR Body

3–5 sentences across all sections. Reviewers read the diff, so the body gives context and intent only.

- Plain English that a reviewer outside the team can follow. No mannered prose, jargon, internal flag names, or `file:line` references.
- No evidence tables, audits, or test matrices. Put detail in the chat reply instead.
- Keep each paragraph on one line. GitHub renders a single newline as a line break.
- If the repo has `.github/pull_request_template.md`, follow it instead of the sections below.

Use `##` headings. Drop any section the title or diff already covers:

```markdown
## Why

<One or two sentences: the problem or goal.>

## What Changed

<Short bullets, only for non-obvious changes: a workaround, a temporary guard, something left off on purpose.>

## How I Tested

<One sentence or a short list of the checks that confirmed it works.>
```

In work repos, if the branch name or conversation has a Jira key (e.g. `PLB-123`), make the first line of Why `Jira: [PLB-123](https://wealthsimple.atlassian.net/browse/PLB-123)`.

## Creating the PR

```bash
git log main..HEAD --oneline
git diff main..HEAD --stat

cat <<'EOF' > /tmp/pr-body.md
## Why

<motivation>
EOF

gh pr create --draft \
  --title "<semantic title under 70 chars>" \
  --body-file /tmp/pr-body.md
```

- Always open as draft.
- Title uses semantic commit format (`feat:`, `fix:`, `chore:`, `refactor:`, `docs:`), e.g. `feat: add webhook retry logic`.
- Base is `main` unless the repo's default branch differs.
- Print the PR URL.

## Stacked PRs

Use `gh stack`, not `gh pr create --base <parent>`. Each PR body follows the rules above.

- New stack: `gh stack init <bottom> ... <top>`, commit on each branch, then `gh stack submit --auto` (opens drafts and links them).
- PRs already open: `gh stack init <branches>`, then `gh stack link <pr> <pr> ...`.
- Updates: `gh stack rebase`, `gh stack sync`, `gh stack push`.
- `gh stack add` only appends at the top. To insert lower or repair a stack, run `gh stack link <stack#> <prs...>`, `gh stack unstack --local`, then `gh stack checkout <stack#>`.
- Confirm with `gh stack view`.

## Watch CI in the Background

Don't block the session on CI. Run the watch with the Bash tool's `run_in_background: true`, give the user the PR URL, and end the turn or keep working. The harness notifies you when the command exits, so don't poll it. For a stack, start one watch per PR.

```bash
# Wait for checks to register after the push, then watch until they finish
until gh pr checks <number> --json name >/dev/null 2>&1; do sleep 15; done
gh pr checks <number> --watch --fail-fast --interval 30
gh pr checks <number> --json name,bucket --jq '.[] | "\(.bucket) \(.name)"'
```

When notified, read the final check states from the output:

- All `pass` or `skipping`: tell the user CI is green.
- Any `fail`: run `gh run view <run-id> --log-failed`, find the cause, push the fix as a new commit (`fix: resolve CI failure in <area>`), and start a fresh background watch.
- Stop after 3 fix rounds and ask the user.
- Don't re-run without a code change. If a re-run passes with no change, tell the user the check is flaky.
