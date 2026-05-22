# Publication Checklist

Use this checklist before publishing the repository or modifying this context folder.

## PII / identifier review

Confirm there are no:

- Corporate usernames or employee IDs embedded in paths (note the `[safe]` directory entries in `git/.gitconfig` — review them).
- Internal hostnames or machine identifiers.
- Absolute `$HOME` paths that encode a real username; use `~` or `<repo>` in docs.
- Email addresses or names beyond the Git identity already public in commit history.

## Secret review

Confirm there are no:

- API keys, tokens, or passwords in any config, alias, or script.
- SSH private keys or TLS certificates.
- Database connection strings or `~/.pgpass` contents.
- Cloud or service credentials in `kubectl` / `argocd` / `flux` alias targets or anywhere else.

## Real-data review

Confirm there are no:

- `~/.psql_history` or shell history files.
- Real database dumps or production data fixtures.
- Screenshots or wallpapers containing sensitive on-screen content.

## Configuration review

Confirm example configuration in `docs/context/` uses synthetic placeholder values, not real production constants — synthetic repo URLs, `~`-relative paths, placeholder hostnames.

## Technical-disclosure review

Confirm there are no:

- Internal infrastructure diagrams or network details.
- Corporate project names beyond what is unavoidable.
- Internal incident notes or operational runbooks for non-public systems.

## Scope-language review

Confirm the docs describe the system as it actually is: an install-and-version tool for one person's environment that *links or copies, skipping existing files* — not a turnkey installer, not a sync service, not a tool installer. Neither oversold nor missing the central claim of a safe, idempotent, non-destructive run.

## Example-data review

Confirm every example in this folder uses synthetic placeholders — `<repo>`, `<repo-url>`, `~`, placeholder enum values — and no real machine transcript.

## Final review

Before publishing:

- Run a secret scanner over the full tree and the Git history.
- Manually diff the changes being published.
- Confirm `.gitignore` excludes runtime-written files (history, caches, plugin install dirs).
- Strip EXIF / location metadata from any committed image (e.g. wallpapers).
- Re-read `git/.gitconfig` for host-specific `[safe]` paths and decide whether to keep, parameterize, or drop them.
