---
mode: "agent"
description: "Agent that reformats Markdown files using Semantic Line Breaks according to the full SemBr specification. The output must be raw Markdown with applied semantic line breaks. Do not parse or interpret the output."
---

# Task

Apply **Semantic Line Breaks (SemBr)** to all Markdown (`.md`) documents in
the current project.

The output must be **raw Markdown** text, rewritten according to the
specification below.

Do not include explanations, parsing, summaries, or comments — only return
the rewritten Markdown document(s).

## Specification

The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”,
“SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this
document are to be interpreted as described in RFC 2119.

1. Text written as plain text or a compatible markup language MAY use
   semantic line breaks.
2. A semantic line break MUST NOT alter the final rendered output of the
   document.
3. A semantic line break SHOULD NOT alter the intended meaning of the text.
4. A semantic line break MUST occur after a sentence, as punctuated by a
   period (.), exclamation mark (!), or question mark (?).
5. A semantic line break SHOULD occur after an independent clause as
   punctuated by a comma (,), semicolon (;), colon (:), or em dash (—).
6. A semantic line break MAY occur after a dependent clause in order to
   clarify grammatical structure or satisfy line length constraints.
7. A semantic line break is RECOMMENDED before an enumerated or itemized
   list.
8. A semantic line break MAY be used after one or more items in a list in
   order to logically group related items or satisfy line length
   constraints.
9. A semantic line break MUST NOT occur within a hyphenated word.
10. A semantic line break MAY occur before and after a hyperlink.
11. A semantic line break MAY occur before inline markup.
12. A maximum line length of 80 characters is RECOMMENDED.
13. A line MAY exceed the maximum line length if necessary, such as to
    accommodate hyperlinks, code elements, or other markup.

## Goals

1. For Writers: The agent SHALL structure Markdown text so that the
   physical layout of lines reflects the logical and semantic structure of
   the author’s thoughts.
2. For Editors: The agent SHALL produce output that makes grammatical and
   structural relationships easier to identify, supporting clear and
   efficient editing without changing meaning.
3. For Readers: The agent SHALL ensure that applied semantic line breaks
   do not alter the rendered appearance or interpretation of the text in
   any Markdown renderer.

## Formatting Rules

- Preserve existing Markdown structure (headings, lists, code blocks,
  tables, HTML, etc.).
- Skip fenced code blocks, inline code, and HTML verbatim.
- Maintain paragraph integrity — do not insert empty lines unless
  already present.
- When in doubt, prefer breaking after complete thoughts or clauses.
- Output only the transformed Markdown content — do not add any metadata,
  explanations, or syntax highlighting.

## Input

Markdown file(s) from the workspace.

## Output

Raw Markdown text with Semantic Line Breaks applied.

Do **not** parse, explain, or wrap the output — return only the processed
Markdown content.
