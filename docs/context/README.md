# Context

This folder is the design-context tree for the **dotfiles** repository — one person's terminal environment (Neovim, Bash, Git, Kitty, Ghostty, PostgreSQL client) packaged as version-controlled config files plus an idempotent bootstrap script. The 17 numbered slots describe what the project is, how it installs, what can go wrong, and what its install layout locks. Publication status: **draft** — not yet reviewed against `13_publication_checklist.md`.

## What this folder includes

- The project summary, problem statement, and design principles (slots 00–02).
- The architecture, install flow, and the data shapes the bootstrap script reasons about (slots 03–05).
- The operational risk model and data-handling rules (slots 06–07).
- Environmental assumptions, current scope, and roadmap (slots 08–10).
- End-to-end scenarios and a glossary (slots 11–12).
- The pre-publication checklist and issue-reporting guidance (slots 13–14).
- Code-level implementation notes and the locked install-layout contract (slots 15–16).

## File index

| File | Purpose |
|------|---------|
| `00_project_summary.md` | One-page summary and core claim |
| `01_problem_statement.md` | Problem, design challenge, central claim |
| `02_product_principles.md` | Numbered design principles |
| `03_system_architecture.md` | Module map, data flow, trust boundary |
| `04_install_flow.md` | Stage-by-stage description of one bootstrap run |
| `05_data_model.md` | Public-safe data shapes (symlink/copy pairs) |
| `06_risk_model.md` | Operational failure modes and mitigations |
| `07_data_handling.md` | Sensitive-data handling and acceptable use |
| `08_assumptions.md` | Environmental assumptions |
| `09_scope.md` | Current scope and success criteria |
| `10_roadmap.md` | Near / medium / long / deferred |
| `11_scenarios.md` | End-to-end walkthroughs |
| `12_glossary.md` | Terms and preferred language |
| `13_publication_checklist.md` | Pre-publish review |
| `14_issue_reporting.md` | How to report bugs and accidental disclosures |
| `15_implementation_notes.md` | Code-level guidance |
| `16_install_contract.md` | Locked install-layout specification |

Slots 04 and 16 were renamed (`core_flow` → `install_flow`, `canonical_outputs` → `install_contract`) to read naturally for a dotfiles installer; slot numbers and ROLE intent are unchanged.

## What this folder must not include

Per `13_publication_checklist.md`, nothing here may contain: PII or corporate identifiers, secrets or credentials, real shell/`psql` history, real production configuration values, internal infrastructure detail, or non-synthetic example data. Real host-specific paths (such as the `[safe]` directory entries in `git/.gitconfig`) must be reviewed before this folder or the repo is published.

## Publication principle

This folder exists to give a reader — the owner returning later, a contributor, or someone browsing for ideas — a complete and honest picture of the project without reading all the code. It is a design-context tree, not marketing and not a runbook: it states what the project does, what it does not promise, and where it can fail. It is kept publishable so it can be shared as-is, which is only true while every slot stays free of secrets and host-identifying data.
