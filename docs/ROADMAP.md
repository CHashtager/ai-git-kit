# Roadmap

## Now

- Use this repo as the home for cross-tool decisions.
- Keep `kmit` and `patchlens` independently buildable.
- Add local orchestration commands for status, tests, and builds.
- Normalize terminology across both tools: provider, model, token, repo, project, MR, PR, mode, context file.

## Next

- Add a compatibility matrix for released versions.
- Define shared config conventions.
- Compare duplicated code between `kmit` and `patchlens`.
- Add a release checklist for each tool.
- Decide whether a combined installer is useful for personal use.

## Later

- Extract a shared Go module if duplication becomes stable and expensive.
- Publish install docs for Homebrew or `go install`.
- Consider reviving the VS Code extension as a UI around the CLIs.
- Add end-to-end examples that use `kmit` and `patchlens` together in one workflow.

