# Development Workflow

CMNA uses a lightweight Git Flow variant suited to the current two-person
working arrangement.

## Branch roles

- `main` is release-only and represents published, stable versions.
- `develop` is the active integration branch and the normal destination for
  routine CMNA work.
- `release/**` remains available for release stabilization.
- `hotfix/**` remains available for urgent fixes to published releases.
- Feature branches and pull requests are optional tools for risky,
  experimental, externally contributed, or independently reviewed work.

## Normal development

Routine, coherent changes may be committed directly to `develop` when they:

1. have a clear and descriptive commit message;
2. include the relevant implementation, tests, and documentation;
3. preserve a reviewable commit history;
4. trigger the repository's normal CI checks; and
5. are corrected or reverted promptly if those checks fail.

The next numerical slice should not begin until the current `develop` tip is
green.

## Pull requests

Pull requests are not required for ordinary work by the current development
unit. They should be used when they provide concrete value, including:

- independent review;
- discussion among multiple contributors;
- protected-branch approval;
- isolation of substantial experimental work; or
- a durable review record for an external contribution.

## Releases

Development is never committed directly to `main`. Approved release work moves
from `develop` through an appropriate release process and is then tagged on
`main`.
