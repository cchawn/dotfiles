# review-pr config

Copy this file to `local/config.md` beside `SKILL.md` and fill it in. `local/` is gitignored, so names specific to your workplace stay out of the tracked skill. Leave a value blank to skip the step that uses it.

- **Clones root:** `~/code`. Local clones live at `<clones root>/<repo>`.
- **GitHub org:** `my-org`. Used for org-wide PR searches.
- **Jira project for related work:** `ABC`.
- **Global ADR repo:** `my-org/architecture-decisions`, cloned at `<clones root>/architecture-decisions`. Folders to read: `docs/`.
- **Automated reviewer:** plugin key `<plugin>@<marketplace>` in `~/.claude/plugins/installed_plugins.json`, skill file `skills/<skill>/SKILL.md` under the plugin's install path.
- **MCP tools** (fully qualified names):
  - Jira ticket: `mcp__<server>__<tool>`
  - Jira search: `mcp__<server>__<tool>`
  - Slack search: `mcp__<server>__<tool>`
  - Enterprise search, which also covers Slack: `mcp__<server>__<tool>`, with `<how to filter to Slack>`
  - Cross-repo code search: `mcp__<server>__<tool>`
