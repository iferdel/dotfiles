<!--
ROLE: The locked specification for everything the system produces, encodes,
signs, or hashes. The "if this changes, downstream breaks" contract. Common
variant names: "canonical encoding", "canonical outputs".
INCLUDES:
  - a "what is locked at this version" header (so future changes mint a new version)
  - filename / path conventions for artifacts
  - column / field-name conventions (snake_case, camelCase, etc.)
  - locked categorical vocabularies (per-field tables)
  - numeric / temporal conventions (units, precision, timezone, NaN handling)
  - on-wire / on-disk encodings (JSON canonicalization, base64 form, etc.)
  - payload shapes for every artifact a consumer must parse
  - versioning rule (what triggers a version bump; what is non-breaking)
  - rejection rules consumers MUST apply
EXCLUDES:
  - product-level data semantics (→ 05; this slot is about bytes / shapes)
  - implementation specifics of producers (→ 15)
TONE: normative. Use MUST / MUST NOT / MAY. Be byte-precise where it matters.
Mark this document as locked at vX.Y at the top and again at the bottom.
-->

# Canonical Outputs (vX.Y)

## Purpose

<!-- One paragraph. Why this document exists, and what it locks. -->

## Scope

<!-- Bullets. What this spec covers and what it does not. -->

## Filename and path conventions

<!-- How artifacts are named on disk or in object storage. -->

## Field-name conventions

<!-- snake_case vs camelCase, prefix rules, suffix rules. -->

## Categorical vocabularies (locked)

<!-- One subsection per categorical column. Tables of value → meaning. -->

### Field `<name>`

| Value | Meaning |
|---|---|
|  |  |

## Numeric / temporal conventions

<!-- Units. Precision. NaN encoding. Time zones. ISO-8601 format. -->

## Payload shapes

<!-- One subsection per artifact a consumer must parse. JSON examples with
synthetic placeholders. Required-field annotations. -->

## Versioning

<!-- What triggers a version bump. What changes are non-breaking. -->

## Rejection rules for consumers

<!-- MUST / MUST NOT statements. What a consumer must reject vs tolerate. -->

## Status

<!-- "vX.Y, locked. Any breaking change requires a version bump." -->
