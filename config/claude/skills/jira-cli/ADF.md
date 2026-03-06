# Atlassian Document Format (ADF)

Jira Cloud uses ADF for rich text. Use `--from-json` with a JSON file in this structure:

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

## Key Gotchas

- `--from-json` and `-k` cannot be used together — put issue keys in the `"issues"` array
- `--from-json` prompts for confirmation — add `-y` to skip
- Generate a template with `acli jira workitem edit --generate-json`

## Node Types

`heading`, `paragraph`, `bulletList`, `orderedList`, `listItem`, `codeBlock`, `table`

## Text Marks

`strong`, `em`, `code`, `link` (with `attrs.href`), `strike`, `underline`
