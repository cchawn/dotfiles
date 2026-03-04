---
name: gh-pr
description: Use when creating a pull request on GitHub. Covers pre-flight checks, pushing commits, and opening a draft PR with a structured body.
---

# GitHub Pull Request (`gh pr create`)

Uses the `gh` CLI to open a draft pull request with a structured description.

## Pre-flight Checks

Run these checks before creating the PR. Abort and inform the user if any fail.

```bash
# 1. Must be on a feature branch (not main/master)
branch=$(git branch --show-current)
if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
  echo "ERROR: Cannot create PR from $branch. Switch to a feature branch first."
  exit 1
fi

# 2. All commits must be pushed to remote
if [ -n "$(git log origin/$branch..$branch 2>/dev/null)" ]; then
  echo "Unpushed commits detected. Pushing..."
  git push -u origin "$branch"
fi
```

## Detecting a PR Template

```bash
# Check for a repository PR template
template=""
for f in .github/PULL_REQUEST_TEMPLATE.md .github/pull_request_template.md docs/pull_request_template.md PULL_REQUEST_TEMPLATE.md; do
  if [ -f "$f" ]; then
    template="$f"
    break
  fi
done
```

If a template exists, read it and fill in the sections. If no template exists, use the default structure below.

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

# Create draft PR using heredoc for the body
gh pr create --draft \
  --title "<concise title under 70 chars>" \
  --body "$(cat <<'EOF'
## Why

<motivation>

## What Changed

<summary>

## How I Tested

<verification>
EOF
)"
```

### Key Rules

- Always create as **draft** (`--draft`)
- PR title: semantic commit format — `fix:`, `feat:`, `chore:`, `refactor:`, `docs:`, etc. Under 70 characters. Example: `feat: add webhook retry logic`
- Base branch defaults to `main` — override with `--base <branch>` if the repo uses a different default
- After creation, output the PR URL so the user can review it
- If `gh pr create` fails due to auth, suggest `gh auth login`

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
