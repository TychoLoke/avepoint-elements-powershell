# Contributing

## Principles

- Keep the repository public-safe at all times.
- Do not commit secrets, tokens, certificates, customer data, tenant identifiers from real environments, or copied vendor content.
- Prefer maintainable architecture over quick endpoint wrappers.
- Keep cmdlet naming consistent with approved PowerShell verbs.
- Preserve cross-platform PowerShell 7+ compatibility where practical.

## Development Workflow

1. Create a feature branch from `main`.
2. Make focused changes with tests and documentation updates.
3. Update `CHANGELOG.md` for user-facing changes.
4. Run Pester tests locally before opening a pull request.
5. Keep commit messages clear and professional.

## Public Documentation Rules

- Use only placeholder values in examples.
- Write original explanatory text.
- Link to vendor documentation instead of copying it into the repository.

## Release Hygiene

- Use semantic versioning.
- Tag releases with annotated git tags.
- Keep release notes concise and factual.

