---
name: sentry-cli
description: Use when pulling issue or event information from Sentry, bulk managing issues (mute, resolve), or checking Sentry configuration from the command line.
---

# Sentry CLI - Issue Management

Command line tool for managing Sentry issues and events. Run `sentry-cli --help` for full command list.

## Quick Reference

| Action | Command |
|--------|---------|
| List issues | `sentry-cli issues list -o ORG -p PROJECT` |
| List unresolved | `sentry-cli issues list -s unresolved` |
| Filter by query | `sentry-cli issues list --query "is:unresolved level:error"` |
| List events | `sentry-cli events list -o ORG -p PROJECT` |
| Mute issues | `sentry-cli issues mute -i ISSUE_ID` |
| Resolve issues | `sentry-cli issues resolve -i ISSUE_ID` |
| Unresolve issues | `sentry-cli issues unresolve -i ISSUE_ID` |
| Check config | `sentry-cli info` |

## Configuration

Config file: `~/.sentryclirc` (or `.sentryclirc` in project root, searched upward)

```ini
[auth]
token=your-auth-token

[defaults]
org=your-org
project=your-project
```

Environment variables:
- `SENTRY_AUTH_TOKEN` - Auth token
- `SENTRY_ORG` - Default organization
- `SENTRY_PROJECT` - Default project
- `SENTRY_URL` - Server URL (default: https://sentry.io/)

```bash
# Verify authentication
sentry-cli info

# Verify without org/project defaults
sentry-cli info --no-defaults
```

## Listing Issues

```bash
# Basic list (requires org and project)
sentry-cli issues list -o myorg -p myproject

# Filter by status
sentry-cli issues list -s unresolved
sentry-cli issues list -s resolved
sentry-cli issues list -s muted

# Limit output rows
sentry-cli issues list --max-rows 20

# Limit pages fetched (100 issues/page, default: 5 pages)
sentry-cli issues list --pages 2

# Using Sentry search syntax
sentry-cli issues list --query "is:unresolved level:error"
sentry-cli issues list --query "is:unresolved firstSeen:-24h"
sentry-cli issues list --query "is:unresolved assigned:me"

# Select all issues (may be limited)
sentry-cli issues list -a
```

## Listing Events

```bash
# Basic event list
sentry-cli events list -o myorg -p myproject

# Show user information
sentry-cli events list -U

# Show tags
sentry-cli events list -T

# Limit rows
sentry-cli events list --max-rows 50

# Limit pages (100 events/page, default: 5 pages)
sentry-cli events list --pages 3
```

## Bulk Issue Management

```bash
# Mute a specific issue
sentry-cli issues mute -i ISSUE_ID -o myorg -p myproject

# Mute all unresolved issues
sentry-cli issues mute -s unresolved -o myorg -p myproject

# Resolve specific issue
sentry-cli issues resolve -i ISSUE_ID

# Resolve all muted issues
sentry-cli issues resolve -s muted

# Unresolve specific issue
sentry-cli issues unresolve -i ISSUE_ID

# Bulk operations with --all (use with caution)
sentry-cli issues resolve -a
```

## Query Syntax

Sentry search syntax for `--query` flag. See https://docs.sentry.io/concepts/search/

| Filter | Example |
|--------|---------|
| Status | `is:unresolved`, `is:resolved`, `is:muted` |
| Level | `level:error`, `level:warning`, `level:info` |
| First seen | `firstSeen:-24h`, `firstSeen:-7d` |
| Last seen | `lastSeen:-1h`, `lastSeen:-24h` |
| Assigned | `assigned:me`, `assigned:nobody`, `assigned:user@example.com` |
| Times seen | `times_seen:>100` |
| Platform | `platform:python`, `platform:javascript` |
| Release | `release:1.0.0`, `release:latest` |
| Environment | `environment:production` |

Combine filters: `is:unresolved level:error firstSeen:-24h`

## Common Workflows

```bash
# Find recent unresolved errors
sentry-cli issues list --query "is:unresolved level:error firstSeen:-24h"

# Get issue count for a project
sentry-cli issues list -s unresolved --max-rows 0 2>&1 | grep -o '[0-9]* issues'

# Bulk resolve old issues
sentry-cli issues resolve --query "is:unresolved lastSeen:-30d"

# Export issues (use quiet mode + scripting)
sentry-cli issues list -s unresolved --max-rows 100
```
