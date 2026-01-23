---
name: jira-cli
description: Use when working with Jira issues, sprints, or epics from the command line. Covers listing, creating, viewing, and transitioning issues.
---

# Jira CLI (jira-cli by ankitpokhrel)

Interactive Jira command line tool. Run `jira --help` for full command list.

## Quick Reference

| Action | Command |
|--------|---------|
| List issues | `jira issue list` |
| View issue | `jira issue view ISSUE-1` |
| Create issue | `jira issue create -tBug -s"Summary" -b"Description"` |
| Transition issue | `jira issue move ISSUE-1 "In Progress"` |
| Assign issue | `jira issue assign ISSUE-1 username` |
| Add comment | `jira issue comment add ISSUE-1 -b"Comment text"` |
| Open in browser | `jira open ISSUE-1` |
| List sprints | `jira sprint list` |
| List epics | `jira epic list` |

## Listing Issues

```bash
# Basic list (interactive mode)
jira issue list

# Plain text output (for scripting)
jira issue list --plain

# Filter by status, type, assignee
jira issue list -s"In Progress" -tBug -a"john@example.com"

# Filter by label (multiple labels with multiple -l flags)
jira issue list -lurgent -lbackend

# Unassigned issues
jira issue list -ax

# Issues NOT in a status (use ~ prefix)
jira issue list -s~Done

# Limit results
jira issue list --paginate 20

# Specific columns
jira issue list --plain --columns key,status,assignee,summary

# Raw JQL query
jira issue list -q"status = 'In Progress' AND assignee = currentUser()"
```

## Creating Issues

```bash
# Interactive mode (prompts for fields)
jira issue create

# Non-interactive with all fields
jira issue create -tStory -s"Summary" -b"Description" -yHigh -a"user" -lfeature

# With custom fields
jira issue create -tStory -s"Summary" --custom story-points=3

# Create in different project
jira issue create -pOTHER -tTask -s"Summary"

# Description from file
jira issue create -tTask -s"Summary" --template /path/to/template.md

# Description from stdin
echo "Description" | jira issue create -tTask -s"Summary"
```

## Viewing and Editing

```bash
# View issue details
jira issue view ISSUE-1

# View with comments
jira issue view ISSUE-1 --comments 5

# Raw JSON output
jira issue view ISSUE-1 --raw

# Edit issue (opens editor)
jira issue edit ISSUE-1

# Edit specific field
jira issue edit ISSUE-1 -s"New summary"
```

## Transitions and Workflow

```bash
# Move to new status
jira issue move ISSUE-1 "In Progress"
jira issue move ISSUE-1 Done

# Move with comment
jira issue move ISSUE-1 Done --comment "Completed implementation"

# Move and assign
jira issue move ISSUE-1 "Code Review" -a"reviewer@example.com"
```

## Sprints and Epics

```bash
# List sprints
jira sprint list

# Add issue to sprint
jira sprint add SPRINT-ID ISSUE-1

# List epics
jira epic list

# Add issue to epic
jira epic add EPIC-1 ISSUE-1 ISSUE-2

# Create epic
jira epic create -s"Epic Summary" -b"Description"
```

## Common JQL Patterns

```bash
# My open issues
jira issue list -q"assignee = currentUser() AND status != Done"

# Recently updated
jira issue list --updated -7d

# Created this week
jira issue list --created week

# High priority bugs
jira issue list -tBug -yHigh

# Issues in current sprint
jira issue list -q"sprint in openSprints()"
```

## Configuration

Config file: `~/.config/.jira/.config.yml`

```bash
# Initialize config
jira init

# Check current user
jira me

# Server info
jira serverinfo
```

## Output Flags

- `--plain` - Plain text output (for scripting/parsing)
- `--no-headers` - Hide table headers (with --plain)
- `--no-truncate` - Show all fields (with --plain)
- `--raw` - JSON output
- `--columns key,status,summary` - Specific columns only
