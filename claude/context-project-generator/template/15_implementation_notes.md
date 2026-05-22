<!--
ROLE: Code-level guidance that a contributor needs to navigate the project
without re-deriving it from the source. The public-safe counterpart to
internal runbooks.
INCLUDES:
  - orchestration / entry points (which file is "main", how a run starts)
  - per-module shape (the contract each module exposes)
  - the few non-obvious algorithms in enough detail to maintain them
  - library / dependency choices (and why, briefly)
  - configuration knobs and tunable parameters
  - testing approach
  - repo hygiene (env handling, secret scanning, sample fixtures)
  - future implementation directions (one paragraph; cross-link to roadmap)
EXCLUDES:
  - byte-level output specs (→ 16)
  - product-level scope (→ 09)
  - data shapes (→ 05)
TONE: practical and concrete. Name actual functions, files, and constants
when they exist. Prefer code blocks over prose for procedural content.
-->

# Implementation Notes

## Purpose

<!-- One paragraph: what this file is for, and what it is not. -->

## Orchestration

<!-- Where does a run start? What is the entry point? How are failures
isolated across units of work? -->

## Module shape

<!-- For each major module, the contract it exposes (function signatures,
inputs / outputs at the type level). -->

## Key algorithms

<!-- The 1–3 algorithms whose correctness matters most. Enough detail that
a maintainer can debug them; less than a paper. -->

## Configuration knobs

<!-- Tunables: where they live, what they control, recommended defaults,
and the kind of evidence that justifies changing them. -->

## Testing

<!-- How tests are organized and run. Naming conventions. Synthetic-fixture
approach. -->

## Repo hygiene

<!-- env handling, secret scanning, what is committed vs ignored. -->

## Future directions

<!-- One paragraph. The direction the implementation is heading, cross-
linked to the roadmap. -->
