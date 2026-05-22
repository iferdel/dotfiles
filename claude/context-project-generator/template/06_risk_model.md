<!--
ROLE: What can go wrong. The system's risk model, framed for the project's
domain — adversarial threats, operational failures, data-quality risks, or
all three. Common variant names: "threat model", "failure model".
INCLUDES:
  - assets (what is worth protecting / preserving correctness of)
  - trust boundaries (partially trusted, not fully trusted)
  - threat actors OR failure modes (the units of risk for this project's domain)
  - per-actor / per-mode mitigations
  - attack / failure classes (replay, tampering, sybil, drift, staleness, etc.)
  - residual risks (what the system cannot mitigate; honest leftover)
  - preferred / discouraged language when describing the system's guarantees
EXCLUDES:
  - exploitation playbooks or step-by-step abuse instructions
  - implementation patches (→ 15)
  - acceptable-use policy (→ 07)
TONE: cautious. Prefer "the system mitigates X by Y, but cannot rule out Z"
over "the system prevents X".
-->

# Risk Model

## Scope

<!-- 1 paragraph: what kind of risk this document covers (security,
operational, data-quality, or a combination). -->

## Assets

<!-- Bullets or paragraph: what the system protects or preserves correctness of. -->

## Trust boundaries

### Partially trusted

<!-- Bullets. -->

### Not fully trusted

<!-- Bullets. -->

## Threat actors / failure modes

<!-- One subsection per actor or mode. Each has a brief description plus
explicit mitigations. -->

### Actor / mode A

Mitigation:

### Actor / mode B

Mitigation:

## Attack / failure classes

<!-- Cross-cutting categories (replay, tampering, sybil, drift, staleness, etc.). -->

## Residual risks

<!-- Bullets. What the system honestly cannot rule out. -->

## Preferred / discouraged language

Use:

<!-- Bullets. -->

Avoid:

<!-- Bullets. -->
