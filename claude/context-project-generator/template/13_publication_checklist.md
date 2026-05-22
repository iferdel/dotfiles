<!--
ROLE: Pre-publication review checklist. The literal list to walk down before
making the repo, this folder, or any artifact public.
INCLUDES:
  - PII / identifier review
  - secret review
  - real-data review (media, dumps, fixtures)
  - configuration review (no real values masquerading as examples)
  - technical-disclosure review (exploits, infra diagrams)
  - scope-language review (does the doc accurately describe the project?)
  - example-data review (synthetic placeholders only)
  - final review checklist (secret scan, manual diff, .gitignore)
EXCLUDES:
  - the philosophy of why each rule exists (→ 07)
  - reporting procedures (→ 14)
TONE: literal checklist. "Confirm there are no ..." form. Aim for items
that can be ticked yes/no.
-->

# Publication Checklist

Use this checklist before publishing the repository or modifying this context folder.

## PII / identifier review

Confirm there are no:

<!-- Bullets. Categories of personal or operationally-sensitive identifiers. -->

## Secret review

Confirm there are no:

<!-- Bullets. Credentials, tokens, keys, certs. -->

## Real-data review

Confirm there are no:

<!-- Bullets. Real media, dumps, fixtures from production. -->

## Configuration review

<!-- Confirm example config uses synthetic values, not real production constants. -->

## Technical-disclosure review

Confirm there are no:

<!-- Bullets. Exploit details, internal infra diagrams, internal incident notes. -->

## Scope-language review

<!-- Confirm the docs describe the system as it actually is — neither
oversold (false promises) nor undersold (missing key claim). -->

## Example-data review

<!-- All examples use synthetic placeholders. -->

## Final review

Before publishing:

<!-- Bullets. Secret scan, manual diff, .gitignore check, image EXIF strip. -->
