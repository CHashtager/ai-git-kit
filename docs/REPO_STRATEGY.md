# Repository Strategy

## Decision

Manage `ai-git-kit` as an umbrella/meta repository.

`kmit` and `patchlens` should stay as standalone repositories for now. They are both small Go CLIs with different user entry points:

- `kmit` works inside a local repository and helps produce commit messages.
- `patchlens` works against GitHub pull requests and GitLab merge requests and helps review patches.

The original `gitlab-ai-assistant` VS Code extension should remain the historical source and possible future integration surface, not the place where the extracted CLIs are developed.

## Why Not Merge Everything Now

A monorepo would make shared code easier, but it would also raise the cost of simple CLI releases, make install paths less obvious, and couple two tools that can currently evolve independently.

For personal use and early public iteration, the better tradeoff is:

- one repo per user-facing binary;
- one umbrella repo for coordination;
- shared code only when the duplication becomes painful and stable enough to name.

## What Belongs Here

This repo should contain:

- cross-project roadmap and design notes;
- release checklists and changelog coordination;
- local scripts that run tests/builds across checked-out tools;
- packaging experiments, such as Homebrew, install scripts, or combined documentation;
- decisions about shared configuration names, LLM provider behavior, prompts, and security posture.

This repo should not contain:

- duplicated source code from `kmit` or `patchlens`;
- generated binaries;
- secrets or personal config files;
- tool-specific issues that only affect one repo.

## Local Repo Layout

Use `worktrees/` for local clones:

```text
ai-git-kit/
  docs/
  Makefile
  worktrees/
    kmit/
    patchlens/
    gitlab-ai-assistant/
```

`worktrees/` is intentionally ignored by git. It is a local convenience, not source.

If you later want reproducible pinned checkouts, add git submodules under `repos/` instead. For now, local clones are simpler and avoid submodule friction.

## Shared Code Policy

Do not create a shared library immediately. Start with conventions:

- align config keys where the same concept exists in both tools;
- align provider names and model option names;
- align output modes and exit-code semantics;
- align security/privacy language in docs;
- keep prompt contracts documented before extracting prompt code.

Create a shared Go module only when at least two tools need the same non-trivial implementation and the API has survived real usage.

Good extraction candidates:

- LLM provider clients;
- config redaction and file permissions;
- Git remote parsing;
- GitHub/GitLab URL parsing;
- common review/commit prompt primitives.

Poor extraction candidates:

- CLI command wiring;
- tool-specific prompt wording;
- output formatting that serves different workflows;
- premature abstractions around tiny helpers.

## Release Flow

Each product repo should keep its own version and changelog.

Use this umbrella repo for a release matrix:

| Tool | Version | Notes |
| --- | --- | --- |
| `kmit` | independent | Commit-message assistant CLI |
| `patchlens` | independent | PR/MR review CLI |

When releases become regular, add:

- `docs/releases/YYYY-MM.md` for monthly notes;
- one checklist per tool;
- an umbrella "known compatible versions" table.

## When To Reconsider

Revisit this strategy if any of these become true:

- both CLIs share more than a small amount of copied provider/config/git code;
- releases are always coordinated together;
- users expect one install command that includes all tools;
- you want one issue tracker and one contribution flow;
- the VS Code extension is revived as a thin shell around the CLIs.

At that point, consider either a Go workspace monorepo or a separate shared Go module.

