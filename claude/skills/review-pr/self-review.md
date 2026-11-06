# Self-review mode

Reviewing your own work on the current branch before its PR exists, so you catch what a reviewer would. You're the author here: fix what you find yourself instead of drafting comments. Everything in SKILL.md applies except what this file changes.

## What changes

- **No GitHub writes at all.** No PR, no pending review, no comments, no browser. Opening the PR stays with whoever asked for the review (for example, the `gh-pr` skill afterwards).
- **Review in place.** You may edit and commit on your own branch; skip the worktree.
- **The target is your branch against its base**, not a PR: the merge base with `origin/<default branch>` (or the base you'll open the PR against) up to your working tree, including uncommitted changes.
- **Skip the steps that need a PR:** reading review threads (step 1), the worktree (steps 2 and 11), and CI on the head SHA (step 8).

## Workflow

```
Self-review progress:
- [ ] 1. Gather the diff and the ticket
- [ ] 2. Spawn the automated reviewer in the background
- [ ] 3. Search for duplicate and related work
- [ ] 4. Read global and in-repo ADRs and docs
- [ ] 5. Compare the ticket and the code
- [ ] 6. Verify every candidate finding
- [ ] 7. List undocumented decisions
- [ ] 8. Fix, re-check, and report
```

**1. Gather.** `git fetch origin <base>`, then `git diff origin/<base>...HEAD` plus `git diff` for uncommitted work. Find the Jira key in the branch name, commits or your task, and read the ticket and its parent.

**2 to 7.** Follow SKILL.md's steps 3, 4, 5, 6, 7 and 9 in that order, with the repository root as the checkout and `origin/<base>` as the base ref. If the duplicate-work search finds someone else's open PR doing the same thing, stop and say so before fixing anything.

**8. Fix, re-check, and report.**
- Fix every 🔴 and 🟠 finding in new commits. Fix a 🟡 when it's quick, or list it as left.
- Add each undocumented decision where SKILL.md step 9 says it belongs. A decision that belongs in the PR body goes in your report, for whoever writes the PR.
- Run the repo's tests and linters for what you changed, and re-run the automated reviewer once if you changed more than a few lines.
- Report in chat, briefly: what you fixed, what you left and why, the decisions for the PR body, and anything only a person can answer. A finding you can't fix without a person (access, a product decision) is a blocker: say so plainly.
