# ai-git-kit

`ai-git-kit` is the umbrella workspace for a small family of AI-assisted Git tools.

The current recommendation is to keep the tools as separate product repositories and use this repo as the coordination layer: shared roadmap, release notes, local development commands, cross-tool design decisions, and eventually shared docs or packaging.

## Projects

| Project | Role | Repository |
| --- | --- | --- |
| `kmit` | Generate, validate, and optionally create commits from local git diffs. | <https://github.com/Chashtager/kmit> |
| `patchlens` | Review GitHub PRs and GitLab MRs locally or by posting summaries and inline comments. | <https://github.com/Chashtager/patchlens> |
| `gitlab-ai-assistant` | Original VS Code extension that bundled GitLab workflow automation, commits, MRs, and AI review. | <https://github.com/CHashtager/gitlab-ai-assistant> |

## Recommended Model

Use this as a meta repo, not the canonical source for each tool.

- Keep `kmit` and `patchlens` independently buildable and releasable.
- Track shared product decisions in `docs/`.
- Use this repo for cross-tool workflows, scripts, release checklists, and local orchestration.
- Move code into a shared library only after the same behavior has been duplicated and stabilized in both tools.

This keeps each CLI easy to install and reason about while still giving the toolkit a single place to grow from.

## Local Workspace

Clone the related repos into `worktrees/` when you want one folder that can operate on all tools:

```sh
mkdir -p worktrees
git clone https://github.com/Chashtager/kmit worktrees/kmit
git clone https://github.com/Chashtager/patchlens worktrees/patchlens
git clone https://github.com/CHashtager/gitlab-ai-assistant worktrees/gitlab-ai-assistant
```

Then use the umbrella commands:

```sh
make status
make test
make build
```

Missing repos are skipped, so this workspace can stay lightweight.

## Docs

- [Repository Strategy](docs/REPO_STRATEGY.md)
- [Roadmap](docs/ROADMAP.md)

