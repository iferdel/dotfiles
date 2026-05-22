<!--
ROLE: Folder-level index for the context tree. Names every file, says what
the folder includes, and says what it must not include. Acts as the
landing page when someone opens the folder for the first time.
INCLUDES:
  - one-paragraph description of the project and what this folder is
  - "what this folder includes" (bullets)
  - file index table (one row per slot)
  - "what this folder must not include" (cross-references slot 13)
  - publication principle (one paragraph)
EXCLUDES:
  - actual content of any slot (those live in their own files)
TONE: index / map. Help the reader navigate the tree, do not re-explain
what is in each file.
-->

# Context

<!-- One paragraph: what project this folder describes, what its
publication status is (draft / public-safe / internal). -->

## What this folder includes

<!-- Bullets summarizing the 17 slots. -->

## File index

| File | Purpose |
|------|---------|
| `00_project_summary.md` | One-page summary and core claim |
| `01_problem_statement.md` | Problem, design challenge, central claim |
| `02_product_principles.md` | Numbered design principles |
| `03_system_architecture.md` | Module map, data flow, trust boundary |
| `04_core_flow.md` | Stage-by-stage description of one run |
| `05_data_model.md` | Public-safe data shapes |
| `06_risk_model.md` | Threats / failure modes and mitigations |
| `07_data_handling.md` | Sensitive-data handling and acceptable use |
| `08_assumptions.md` | Environmental assumptions |
| `09_scope.md` | Current scope and success criteria |
| `10_roadmap.md` | Near / medium / long / deferred |
| `11_scenarios.md` | End-to-end walkthroughs |
| `12_glossary.md` | Terms and preferred language |
| `13_publication_checklist.md` | Pre-publish review |
| `14_issue_reporting.md` | How to report bugs / security / data-quality issues |
| `15_implementation_notes.md` | Code-level guidance |
| `16_canonical_outputs.md` | Locked output specification |

<!-- Rename rows above if any slot file was renamed during fill. -->

## What this folder must not include

<!-- Cross-reference 13_publication_checklist.md. Summarize the categories. -->

## Publication principle

<!-- One paragraph. What the folder is for and what it is not. -->
