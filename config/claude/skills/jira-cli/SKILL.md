---
name: jira-cli
description: Use when working with Jira issues, sprints, or epics from the command line. Covers listing, creating, viewing, and transitioning issues.
---

# Atlassian CLI (acli jira)

Official Atlassian command line tool. Run `acli jira --help` for full command list.

## Quick Reference

| Action | Command |
|--------|---------|
| List issues | `acli jira workitem search --jql "project = PROJ"` |
| View issue | `acli jira workitem view KEY-1` |
| Create issue | `acli jira workitem create -p PROJ -t Bug -s "Summary" -d "Description"` |
| Transition issue | `acli jira workitem transition -k KEY-1 -s "In Progress"` |
| Assign issue | `acli jira workitem assign -k KEY-1 -a "user@example.com"` |
| Add comment | `acli jira workitem comment create -k KEY-1 -b "Comment text"` |
| Open in browser | `acli jira workitem view KEY-1 --web` |
| List sprints | `acli jira board list-sprints --board-id BOARD_ID` |

## Searching Issues

```bash
# Search with JQL query
acli jira workitem search --jql "project = PROJ"

# CSV output (for scripting)
acli jira workitem search --jql "project = PROJ" --csv

# JSON output
acli jira workitem search --jql "project = PROJ" --json

# Filter by status, type, assignee
acli jira workitem search --jql "project = PROJ AND status = 'In Progress' AND issuetype = Bug AND assignee = 'user@example.com'"

# Count results only
acli jira workitem search --jql "project = PROJ" --count

# Limit results
acli jira workitem search --jql "project = PROJ" --limit 20

# Specific columns
acli jira workitem search --jql "project = PROJ" --fields "key,status,assignee,summary" --csv

# Paginate through all results
acli jira workitem search --jql "project = PROJ" --paginate

# Open search in browser
acli jira workitem search --jql "project = PROJ" --web

# Using a saved filter
acli jira workitem search --filter 10001
```

## Creating Issues

```bash
# Create with required fields
acli jira workitem create -p PROJ -t Story -s "Summary" -d "Description"

# With assignee and labels
acli jira workitem create -p PROJ -t Task -s "Summary" -a "user@example.com" -l "feature,urgent"

# Self-assign
acli jira workitem create -p PROJ -t Bug -s "Summary" -a "@me"

# Description from file
acli jira workitem create -p PROJ -t Task -s "Summary" --description-file /path/to/desc.md

# Create as subtask (with parent)
acli jira workitem create -p PROJ -t Sub-task -s "Subtask" --parent KEY-1

# Open editor for summary/description
acli jira workitem create -p PROJ -t Task -e

# JSON output
acli jira workitem create -p PROJ -t Task -s "Summary" --json
```

## Viewing and Editing

```bash
# View issue details
acli jira workitem view KEY-1

# View in browser
acli jira workitem view KEY-1 --web

# JSON output
acli jira workitem view KEY-1 --json

# View specific fields
acli jira workitem view KEY-1 --fields "summary,status,comment"

# View all fields
acli jira workitem view KEY-1 --fields "*all"

# Edit issue summary
acli jira workitem edit -k KEY-1 -s "New summary"

# Edit description (plain text only — no formatting)
acli jira workitem edit -k KEY-1 -d "New description"

# Edit description with rich formatting — use --from-json with ADF (see below)
acli jira workitem edit --from-json /path/to/edit.json -y

# Edit multiple issues with JQL
acli jira workitem edit --jql "project = PROJ AND status = 'To Do'" -a "@me" -y

# Remove assignee
acli jira workitem edit -k KEY-1 --remove-assignee
```

## Rich Text Descriptions (ADF)

Jira Cloud uses Atlassian Document Format (ADF) for rich text. The `-d` flag and `--description-file`
treat input as **plain text** — markdown, wiki markup, and HTML will render as literal strings.

To set a formatted description, use `--from-json` with a JSON file in this structure:

```json
{
  "issues": ["KEY-1"],
  "description": {
    "version": 1,
    "type": "doc",
    "content": [
      {
        "type": "heading",
        "attrs": { "level": 2 },
        "content": [{ "type": "text", "text": "Section Title" }]
      },
      {
        "type": "paragraph",
        "content": [
          { "type": "text", "text": "Regular text, " },
          { "type": "text", "text": "bold text", "marks": [{ "type": "strong" }] },
          { "type": "text", "text": ", " },
          { "type": "text", "text": "italic text", "marks": [{ "type": "em" }] },
          { "type": "text", "text": ", and " },
          { "type": "text", "text": "inline code", "marks": [{ "type": "code" }] }
        ]
      },
      {
        "type": "paragraph",
        "content": [
          { "type": "text", "text": "a link", "marks": [{ "type": "link", "attrs": { "href": "https://example.com" } }] }
        ]
      },
      {
        "type": "bulletList",
        "content": [
          {
            "type": "listItem",
            "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "Bullet item" }] }]
          }
        ]
      },
      {
        "type": "orderedList",
        "attrs": { "order": 1 },
        "content": [
          {
            "type": "listItem",
            "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "Numbered item" }] }]
          }
        ]
      }
    ]
  }
}
```

**Key gotchas:**
- `--from-json` and `-k` cannot be used together — put issue keys in the `"issues"` array
- `--from-json` prompts for confirmation — add `-y` to skip
- Generate a template with `acli jira workitem edit --generate-json`
- ADF node types: `heading`, `paragraph`, `bulletList`, `orderedList`, `listItem`, `codeBlock`, `table`
- Text marks: `strong`, `em`, `code`, `link` (with `attrs.href`), `strike`, `underline`

## Transitions and Workflow

```bash
# Move to new status
acli jira workitem transition -k KEY-1 -s "In Progress"
acli jira workitem transition -k KEY-1 -s "Done"

# Transition multiple issues
acli jira workitem transition -k "KEY-1,KEY-2" -s "Done"

# Transition with JQL (skip confirmation)
acli jira workitem transition --jql "project = PROJ AND status = 'Code Review'" -s "Done" -y

# Transition using filter
acli jira workitem transition --filter 10001 -s "To Do" -y
```

## Comments

```bash
# Add comment
acli jira workitem comment create -k KEY-1 -b "Comment text"

# Comment from file
acli jira workitem comment create -k KEY-1 -F /path/to/comment.txt

# Open editor for comment
acli jira workitem comment create -k KEY-1 --editor

# Edit last comment
acli jira workitem comment create -k KEY-1 --edit-last

# List comments
acli jira workitem comment list KEY-1

# Comment on multiple issues
acli jira workitem comment create --jql "project = PROJ AND status = 'Done'" -b "Closing batch"
```

## Sprints and Boards

```bash
# List boards
acli jira board search

# List sprints for a board
acli jira board list-sprints --board-id BOARD_ID

# View sprint details
acli jira sprint view SPRINT_ID

# List issues in sprint
acli jira sprint list-workitems SPRINT_ID

# Create sprint
acli jira sprint create --board-id BOARD_ID --name "Sprint 1"
```

## Common JQL Patterns

```bash
# My open issues
acli jira workitem search --jql "assignee = currentUser() AND status != Done"

# Unassigned issues
acli jira workitem search --jql "project = PROJ AND assignee IS EMPTY"

# Issues in current sprint
acli jira workitem search --jql "sprint in openSprints()"

# High priority bugs
acli jira workitem search --jql "issuetype = Bug AND priority = High"

# Updated in last 7 days
acli jira workitem search --jql "updated >= -7d"

# Created this week
acli jira workitem search --jql "created >= startOfWeek()"

# Epics
acli jira workitem search --jql "issuetype = Epic AND project = PROJ"

# Issues in an epic
acli jira workitem search --jql "'Epic Link' = KEY-1"
```

## Authentication

```bash
# Login
acli jira auth login

# Check status
acli jira auth status

# Switch accounts
acli jira auth switch

# Logout
acli jira auth logout
```

## Output Flags

- `--csv` - CSV output (for scripting/parsing)
- `--json` - JSON output
- `--fields "key,status,summary"` - Specific columns only
- `--web` or `-w` - Open in browser
- `--count` - Count results only
- `-y` or `--yes` - Skip confirmation prompts
