# Contributing to DevBox Unity

## Project Values

Contributions should support at least one of these goals:

- Reduce setup time
- Reduce maintenance burden
- Improve reproducibility
- Respect the developer
- Improve documentation

## Script Standards

- Use Bash.
- Prefer readable code over clever code.
- Use `set -Eeuo pipefail`.
- Keep scripts idempotent where practical.
- Do not remove user data without confirmation.
- Use helpers from `lib/` instead of duplicating logic.

## Commit Style

Use conventional commits where practical:

```text
feat: add Unity Hub installer
fix: repair Firefox Snap replacement
docs: improve troubleshooting guide
chore: update repository structure
```
