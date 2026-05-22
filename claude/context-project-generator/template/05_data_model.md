<!--
ROLE: Public-safe data models that the system reads and writes. A consumer
should be able to validate inputs and parse outputs against these shapes.
INCLUDES:
  - sanitized example payloads (JSON, code blocks, or table form)
  - field-level semantics for non-obvious fields
  - enum / categorical value vocabularies
  - relationships between entities
  - data-minimization notes (what NOT to include in any artifact)
EXCLUDES:
  - byte-level encoding (→ 16)
  - implementation specifics of producers / consumers (→ 15)
  - real-world example values from the operator's actual data
TONE: schema-style. Concrete examples beat abstract descriptions. Use
synthetic placeholder values everywhere.
-->

# Public Data Model

## Overview

<!-- One paragraph: what entities live here and how they relate. -->

## Entity A

<!-- JSON or table form. Use synthetic placeholders. -->

```json
{
}
```

## Entity B

```json
{
}
```

## Enums / categorical vocabularies

<!-- One subsection per enum, listing the locked values and their meaning. -->

## Relationships

<!-- 1–2 paragraphs or a small diagram showing how the entities reference
each other. -->

## Data minimization

<!-- Bullets. What MUST NOT appear in any artifact derived from these shapes
when shared outside the project. -->
