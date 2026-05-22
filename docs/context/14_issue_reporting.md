# Issue Reporting

## Do not submit sensitive material publicly

Never include in a public issue, PR, discussion, or demo:

- Credentials, tokens, SSH keys, or database connection strings.
- `~/.psql_history` or shell history contents.
- Corporate hostnames, usernames, or machine identifiers.
- Real absolute `$HOME` paths — redact to `~` or `<repo>`.
- Output of a bootstrap run on a real corporate machine.

## Reporting bugs

A useful bug report for this repository contains:

- The platform: macOS / Linux / WSL2 / native Windows.
- Which script was run (`bootstrap.sh` or `bootstrap.ps1`) and from which directory.
- The exact run output, with paths redacted to `~` / `<repo>`.
- What was expected vs. what happened (e.g. "expected a skip, got an overwrite").
- The relevant tool version (`nvim --version`, shell, Neovim plugin lock state) when the bug is config-specific.
- A synthetic reproducer where possible — a minimal directory layout that triggers the issue, not your real home directory.

## Reporting security issues

The realistic "security" issue for a dotfiles repo is an accidental disclosure — a secret or host-identifying path committed to history. If you spot one:

- Do not open a public issue that quotes the secret.
- Report it privately to the repository owner.
- Treat the secret as compromised and rotate it regardless of how briefly it was exposed.
- Describe *where* it is (file, commit) without re-pasting the value.

## Reporting data-quality or abuse concerns

This project produces no decisions and hosts no user-facing content, so there is no data-quality channel. The nearest analogue is a correctness concern — a config that misbehaves or a bootstrap step that is unsafe. Report those as ordinary bugs.

## Public disclosure

Once an accidentally committed secret has been rotated and removed (and history rewritten if the repo is public), the *fact* that a leak occurred and was fixed may be discussed publicly; the secret value itself never may. For ordinary bugs there is no embargo — discuss freely.

## Project limitations

This is a personal dotfiles repository, not a productized installer or a maintained service. There is no SLA, no support channel beyond the owner, and no guarantee the bootstrap scripts behave correctly on a platform the owner does not use. Treat it as one person's environment shared for reference; adapt it rather than relying on it as supported software.
