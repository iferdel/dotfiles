# Assumptions

## Data-source assumptions

The only "source" is the repository clone itself. The bootstrap script assumes it is run from inside that clone, so `DOTFILES_DIR = $(pwd)` resolves to the repo root. If the script is run from elsewhere, every `SRC` path is wrong and the run fails per-pair rather than producing a working install. The script also assumes the repo's directory layout is intact — that `nvim/`, `git/.gitconfig`, `bash/aliases.sh`, and the other sources exist where the `SYMLINK_PAIRS` list expects them.

## Identity / authentication assumptions

There is no authentication. The script runs with the invoking user's own permissions and writes only inside that user's `$HOME`. It assumes it is *not* run as root — destinations under `~/.config` and `~/bin` are meant to be owned by the user. The Git identity is taken as given from `git/.gitconfig`; the script does not verify it.

## Time assumptions

None of any consequence. The conditional copy compares file *content* (`cmp -s`), not modification time, so clock skew between the repo and the home directory cannot cause a wrong copy/skip decision.

## Network / transport assumptions

`bootstrap.sh` and `bootstrap.ps1` perform no network access — they only manipulate the local filesystem. Network access is assumed only by two opt-in, separate paths: `go.sh`, which downloads Go tooling from upstream module hosts, and Neovim's lazy.nvim, which clones plugin repositories on first launch. Both assume working outbound HTTPS and reachable Git hosts; neither runs as part of bootstrap.

## Configuration assumptions

All configuration lives in this repository and is reviewed through ordinary Git history. There is no separate config store and no environment-variable-driven behavior in the bootstrap scripts beyond OS detection. The cadence of change is low and human — a config is edited, committed, and propagated by `git pull` on each machine. The script assumes the parent directories it needs (`~/.config`, `~/bin`) can be created if absent.

## Recipient / consumer assumptions

The "consumer" is the owner's machine and, secondarily, a human reading the repo. There is no programmatic downstream consumer. A human reader is assumed to copy selectively rather than run the installer verbatim.

## Failure-handling assumptions

Failures are isolated per step and per pair: a missing `SRC`, an already-present `DEST`, or an already-present shell-rc line causes that one step to be skipped with a message, while the rest of the run continues. Nothing is retried — there is nothing transient to retry. There is no rollback; a half-completed run is simply re-run, and the skip guards make the re-run safe. A genuinely fatal condition (the dotfiles aliases source file missing entirely) causes an explicit `exit 1`.

## Abuse / misuse assumptions

The security posture is that there is no adversary. The repository is single-author, the scripts run only on deliberate invocation, and there is no network-listening component. The one realistic misuse is *self*-inflicted: committing a secret to a repo that is later published, or running the script from the wrong directory. Both are mitigated operationally — the publication checklist and the working-directory check — rather than by a technical control. The boundary is the user's own discipline, and the documentation says so plainly.
