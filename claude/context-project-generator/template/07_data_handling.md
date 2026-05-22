<!--
ROLE: How the system handles sensitive or commercially-protected data, and
where the line is between what can be shared and what must stay internal.
Common variant names: "privacy and abuse", "data handling", "acceptable use".
INCLUDES:
  - data classes (what kinds of data the system touches; sensitivity per class)
  - the data-handling model (what is encrypted, who can read what, what is logged)
  - what must NOT appear in the repo or in shared artifacts
  - what CAN appear (synthetic fixtures, structural config, etc.)
  - aggregation principle (when row-level vs aggregate is OK)
  - acceptable-use boundaries (what the project is and is not intended for)
  - honest limitation statement (what the project cannot enforce)
EXCLUDES:
  - implementation specifics of access control (→ 15)
  - threat model (→ 06)
TONE: practical, not legal. Speak to "what to do when contributing", not
"jurisdictional analysis". Concrete examples beat policy prose.
-->

# Data Handling

## Data classes

<!-- Table or list: kind of data, where it lives, public-safe? -->

## Data-handling model

<!-- 1–2 paragraphs: how the system treats each class in motion and at rest. -->

## What must NOT appear in the repo

<!-- Bullets. Concrete categories of data, identifiers, and credentials. -->

## What CAN appear

<!-- Bullets. Synthetic fixtures, structural configuration, explanatory docs. -->

## Aggregation principle

<!-- 1 paragraph: when artifacts must aggregate vs when row-level is acceptable. -->

## Acceptable-use boundaries

<!-- Bullets or paragraph: what the project is and is not intended to support. -->

## Honest limitation statement

<!-- 1 paragraph: what the system cannot enforce on its own, and what
operational / cultural practices are doing the work instead. -->
