# GitHub Copilot prompt files

Copilot equivalents of the Claude Code slash commands in `.claude/commands/`.
Each `*.prompt.md` is invoked as `/<name>` in Copilot Chat (VS Code).

Prerequisite (VS Code setting):

```json
"chat.promptFiles": true
```

## Two ways to use them

### 1. Per-repo (committed, shared with a team)
These files already live under `.github/prompts/`. Any Copilot user who opens
this repo gets `/git-gen-commit-msg`, `/create-worktree`, `/fix-github-issue`.

### 2. Personal, available in every project (dotfiles style)
Copy them into the VS Code **user** prompts folder:

- Windows:  `%APPDATA%\Code\User\prompts\`
- macOS:    `~/Library/Application Support/Code/User/prompts/`
- Linux:    `~/.config/Code/User/prompts/`

Example (PowerShell on Windows):

```powershell
$dest = Join-Path $env:APPDATA "Code\User\prompts"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item ".github\prompts\*.prompt.md" $dest -Force
```

## Kept in sync with Claude Code

| Claude Code (`.claude/commands/`) | Copilot (`.github/prompts/`)       |
| --------------------------------- | ---------------------------------- |
| `git-gen-commit-msg.md`           | `git-gen-commit-msg.prompt.md`     |
| `create-worktree.md`              | `create-worktree.prompt.md`        |
| `example-fix-github-issue.md`     | `fix-github-issue.prompt.md`       |

`$ARGUMENTS` in Claude commands maps to `${input:name}` in Copilot prompts.
Repo-wide instructions (`.claude/CLAUDE.md`) map to `.github/copilot-instructions.md`.
