<!--
ROLE: The assumptions the system makes about its environment. When an
assumption breaks, behavior is undefined or degraded — this document is
how a future maintainer recognizes which assumption is suspect. Common
variant names: "security assumptions", "operational assumptions".
INCLUDES:
  - assumptions about data sources (cadence, schema stability, authority)
  - assumptions about identity / authentication (where applicable)
  - assumptions about time / clock skew
  - assumptions about network / transport
  - assumptions about configuration (what is reviewed, what is in version control)
  - assumptions about recipients / downstream consumers (where applicable)
  - assumptions about failure handling (what is retried, what is fatal)
  - assumptions about abuse / misuse (the security posture in one paragraph)
EXCLUDES:
  - mitigations for when assumptions break (→ 06)
  - implementation of any check (→ 15)
TONE: declarative. "The system assumes X. If X is false, Y degrades."
-->

# Assumptions

## Data-source assumptions

<!-- One paragraph or bullets per source. -->

## Identity / authentication assumptions

<!-- Where applicable. -->

## Time assumptions

<!-- Clock skew, timestamp authority, time zones. -->

## Network / transport assumptions

<!-- TLS, retries, ordering, idempotency expectations. -->

## Configuration assumptions

<!-- Where config lives, who reviews it, what the cadence of change is. -->

## Recipient / consumer assumptions

<!-- For systems with downstream consumers. -->

## Failure-handling assumptions

<!-- What is retried automatically; what is fatal; what is on the operator. -->

## Abuse / misuse assumptions

<!-- The security posture in one paragraph: where the boundary is, what
mitigations are operational vs technical. -->
