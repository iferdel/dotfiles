#!/usr/bin/env bash
#
# init-context.sh — scaffold a 17-slot design-context tree into a target dir.
#
# Usage:
#   init-context.sh [target_dir]
#
# target_dir defaults to ./docs/context. Refuses to overwrite an existing target.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/template"
TARGET="${1:-./docs/context}"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "init-context: template directory not found at $TEMPLATE_DIR" >&2
  exit 2
fi

if [ -e "$TARGET" ]; then
  echo "init-context: refusing to write — $TARGET already exists." >&2
  echo "             remove it first or pick a different target." >&2
  exit 1
fi

mkdir -p "$TARGET"
cp -R "$TEMPLATE_DIR/." "$TARGET/"

cat <<EOF
init-context: scaffold written to $TARGET

Next: open Claude Code in this repo and paste the prompt below.

────────────────────────────── FILL PROMPT ──────────────────────────────
Read every file in $TARGET. Each carries an inline <!-- ROLE: ... --> block
describing what belongs in that slot. Read CLAUDE.md (and README.md, plus
whatever source files you need) and fill every template file based on this
project — domain-adapted prose, not placeholder substitution. Rename a slot
file if the generic name reads poorly for this project (the slot number and
ROLE intent are the contract). Strip the ROLE comments from each file once
you have filled it.
─────────────────────────────────────────────────────────────────────────
EOF
