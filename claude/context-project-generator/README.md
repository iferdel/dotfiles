# claude-context-project-generator

Scaffold a reusable 17-slot **design-context** folder into any project, then have Claude fill it from the repo's `CLAUDE.md` and code.

The structure is durable across very different project types (cryptographic protocols, ETL pipelines, web apps, libraries). The 17 numbered slots each have a stable role — what changes between projects is the *content*, not the *shape*.

## Why bother

1. **Claude becomes consistently effective in any repo.** If you keep `/docs/context/` (or `/context/`) in the same shape everywhere, a `context-project` skill can load it before answering and every repo gets the same context-aware Claude.
2. **The slots force articulation.** Writing slot 06 (risk model) or slot 16 (canonical outputs) makes you confront gaps a freeform `README.md` would let you skip. The 17 slots act as a maturity rubric.
3. **The folder is publishable.** With the publication checklist (slot 13) and the data-handling rules (slot 07), the folder can be shared with collaborators, reviewers, or auditors without leaking sensitive material.

## The 17 slots

| # | Slot | Common variant names |
|---|---|---|
| 00 | Project summary | one-page summary + core claim |
| 01 | Problem statement | problem + design challenge + central claim |
| 02 | Product principles | numbered design principles |
| 03 | System architecture | module map + data flow + trust boundary |
| 04 | Core flow | "protocol overview", "pipeline overview", "request lifecycle" |
| 05 | Data model | public-safe data structures and field semantics |
| 06 | Risk model | "threat model", "failure model", "operational risk" |
| 07 | Data handling | "privacy and abuse", "data handling", "acceptable use" |
| 08 | Assumptions | "security assumptions", "operational assumptions" |
| 09 | Scope | "MVP scope", "production scope" |
| 10 | Roadmap | near / medium / long / deferred |
| 11 | Scenarios | "demo scenarios" or "operational scenarios" |
| 12 | Glossary | terms + preferred / discouraged language |
| 13 | Publication checklist | pre-publish review |
| 14 | Issue reporting | "security reporting" or "issue reporting" |
| 15 | Implementation notes | code-level guidance, library choices, hygiene |
| 16 | Canonical outputs | "canonical encoding" or "canonical outputs"; locked specs |

A slot can be renamed when its generic name reads poorly for the project — the **slot number** and **ROLE** are the contract, not the filename.

## Usage

```bash
# Default: writes to ./docs/context (refuses if it already exists)
./init-context.sh

# Or target a different path
./init-context.sh ./context
./init-context.sh /tmp/test-context
```

The script copies the `template/` tree into the target. Each generated file carries an inline `<!-- ROLE: ... -->` block describing what belongs there.

## Filling the scaffold with Claude

After running the script, paste the prompt the script prints (also reproduced here):

> Read every file in `<target_dir>`. Each carries an inline `<!-- ROLE: ... -->` block describing what belongs in that slot. Read `CLAUDE.md` (and `README.md`, plus whatever source files you need) and fill every template file based on this project — domain-adapted prose, not placeholder substitution. Rename a slot file if the generic name reads poorly for this project (the slot number and ROLE intent are the contract). Strip the ROLE comments from each file once you have filled it.

Claude is free to:

- rename a slot file to a more natural name for the project,
- add new sections within a slot,
- skip sections that genuinely don't apply (and say so),
- propose splitting a slot into two if the content warrants it.

Claude should not:

- drop or merge slots without flagging the change,
- leave the ROLE comments in the final files,
- invent project facts not grounded in the repo (better to write "TODO" than to fabricate).

## The ROLE block format

```html
<!--
ROLE:     2–3 sentences on what this slot is for.
INCLUDES: bullets on concrete things to write here.
EXCLUDES: bullets — what does NOT belong here, to avoid bleed between slots.
TONE:     stylistic guidance (e.g. "declarative + honest about limits").
-->
```

The ROLE block is the durable contract for each slot. It is stripped by Claude after filling.

## Folder layout

```
claude-context-project-generator/
├── README.md             ← you are here
├── init-context.sh       ← scaffolder
└── template/             ← bundled template tree (17 slots + README + MANIFEST)
```

## Roadmap for this tool

- Promote to a Claude Code skill (`~/.claude/skills/init-context/`) once the slot roles feel stable across more projects.
- Add a `--rename <old>=<new>` flag if slot renames turn out to be very repetitive.
- Add a back-fill mode that updates an existing context folder with new slots without overwriting filled ones.

Until those land, the script does what it needs to: drops the skeleton, hands off to Claude.
