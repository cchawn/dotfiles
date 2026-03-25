---
name: gh-pr
description: Creates pull requests on GitHub via the gh CLI. Covers pre-flight checks, pushing commits, opening a draft PR with a structured body, and watching CI to fix failures. Use when opening or submitting a pull request.
---

# GitHub Pull Request (`gh pr create`)

Uses the `gh` CLI to open a draft pull request with a structured description.

## Pre-flight Checks

Run these checks before creating the PR. Abort and inform the user if any fail.

```bash
# 1. Must be on a feature branch (not main/master)
# Use git branch --show-current to check the branch name
# Abort if on main or master

# 2. All commits must be pushed to remote
# Compare local branch with its remote tracking branch
# Push with -u if unpushed commits exist
```

## Detecting a PR Template

```bash
# Check for a repository PR template via the GitHub API
# First get the repo name, then fetch templates
repo=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
gh repo view "$repo" --json pullRequestTemplates
```

The response is an array of `{ "body": "...", "filename": "..." }` objects. Use the `body` of the first entry as the template. If the array is empty, use the default structure below.

If a template exists, fill in its sections. If no template exists, use the default structure below.

## PR Body Structure

Always use `##` (H2) headings. The body must include these sections:

```markdown
## Why

<Brief explanation of the motivation — what problem does this solve or what goal does it achieve?>

## What Changed

<Concise summary of the changes — list key modifications, additions, or removals>

## How I Tested

<Describe how the changes were verified — commands run, test results, manual checks>
```

### Adding a Jira Ticket Link

If the branch name contains a Jira ticket key (e.g., `PROJ-123`) or the user mentions one, add it to the **Why** section:

```markdown
## Why

Jira: [PROJ-123](https://jira.atlassian.net/browse/PROJ-123)

<rest of explanation>
```

Infer the Jira base URL from `git remote get-url origin` or prior context. If uncertain, ask the user.

## Creating the PR

```bash
# Gather context for the PR body
git log main..HEAD --oneline          # commits on this branch
git diff main..HEAD --stat            # files changed

# Write the PR body to a temp file
cat <<'EOF' > /tmp/pr-body.md
## Why

<motivation>

## What Changed

<summary>

## How I Tested

<verification>
EOF

# Create draft PR using the body file
gh pr create --draft \
  --title "<concise title under 70 chars>" \
  --body-file /tmp/pr-body.md
```

### Key Rules

- Always create as **draft** (`--draft`)
- PR title: semantic commit format — `fix:`, `feat:`, `chore:`, `refactor:`, `docs:`, etc. Under 70 characters. Example: `feat: add webhook retry logic`
- Base branch defaults to `main` — override with `--base <branch>` if the repo uses a different default
- After creation, output the PR URL so the user can review it
- If `gh pr create` fails due to auth, suggest `gh auth login`

## Watch CI and Fix Failures

After the PR is created, watch for CI failures and iterate until checks pass.

```bash
# Watch the CI run in real time (exits when complete)
gh pr checks --watch

# If any checks fail, inspect the logs
gh run view <run-id> --log-failed
```

### Iteration Loop

1. Run `gh pr checks --watch` to wait for CI results
2. If all checks pass, report success and stop
3. If any checks fail:
   a. Identify the failed run with `gh pr checks`
   b. Inspect logs with `gh run view <run-id> --log-failed`
   c. Diagnose the root cause from the log output
   d. Fix the code locally
   e. Commit and push the fix (`git push`)
   f. Go back to step 1

### Key Rules

- Limit to **3 iterations** — if CI still fails after 3 fix attempts, stop and ask the user for guidance
- Each fix commit should use semantic format: `fix: resolve CI failure in <area>`
- Do not blindly retry without a code change — always diagnose before fixing
- If a failure is flaky (passes on re-run without changes), note it to the user rather than making unnecessary code changes

## Quick Reference

| Action | Command |
|--------|---------|
| Create draft PR | `gh pr create --draft --title "..." --body "..."` |
| Create PR with template | `gh pr create --draft --template` |
| Set base branch | `gh pr create --draft --base develop` |
| Add reviewers | `gh pr create --draft --reviewer user1,user2` |
| Add labels | `gh pr create --draft --label bug,urgent` |
| View open PRs | `gh pr list` |
| View PR in browser | `gh pr view --web` |
| Watch CI checks | `gh pr checks --watch` |
| View failed run logs | `gh run view <run-id> --log-failed` |
