<!--
ROLE: Stage-by-stage description of how the system actually works in one
run. The "tour" through the codebase that explains what each transformation
does and why. Often called "protocol overview", "pipeline overview",
"request lifecycle", or similar — rename this file if a more natural name
exists for the project.
INCLUDES:
  - the stages in order (ingest → transform → output, or equivalent)
  - what each stage takes in and produces
  - per-stage semantics (validation, ordering, replay, idempotency)
  - replay / determinism rules
  - any scoping flags / cutoffs / filters that affect a run
EXCLUDES:
  - module-level layout (→ 03)
  - schema-level field definitions (→ 05)
  - algorithm details (→ 15)
TONE: procedural. A reader following along should be able to trace one
record / request / event from start to finish.
-->

# Core Flow

## Purpose

<!-- One paragraph: what one "run" of the system means in this project. -->

## Stages

```text
<!-- One-line summary of each stage, separated by arrows. -->
ingest → ... → output
```

### 1. Ingest

<!-- What gets read in, from where, with what schema. -->

### 2.

<!-- ... -->

### 3.

### 4. Output

<!-- What gets written, where, with what guarantees. -->

## Determinism and replay

<!-- 1–2 paragraphs. What inputs uniquely determine one run's output. Whether
re-running with the same inputs is byte-equivalent. -->

## Scoping

<!-- Filters / flags / cutoffs that narrow what a single run processes. -->
