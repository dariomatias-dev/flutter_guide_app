## What

<!-- What this change does, in a sentence or two. Link the issue it came from. -->

Closes #

## Why

<!-- The problem it solves. Skip only if the "What" already makes it obvious. -->

## Checklist

Tick what applies, delete what does not, and say why for anything left out.
The rules behind each line live in `CONTRIBUTING.md` and `CLAUDE.md`. They are
named rather than linked: a relative link written here lands in the pull
request body, where it no longer resolves.

**Code**

- [ ] Follows the existing structure: feature-first, `data`/`domain`/`presentation`, Riverpod for state
- [ ] No inline colors, spacing, radii, durations or text styles where the theme already carries the value
- [ ] No hardcoded user-facing text
- [ ] Catalog samples keep their literals inline: they are teaching material, not app code

**Tests**

- [ ] New logic has tests, failure paths included
- [ ] A bug fix has a test that fails without the fix
- [ ] `test/` still mirrors `lib/src/`

**Generated and localized**

- [ ] `fvm flutter gen-l10n` re-run, output committed
- [ ] New strings added to all three ARB files (`en`, `es`, `pt`), with a description in the template

**Documentation**

- [ ] Docs updated in all three languages, if the change touched behaviour, structure, tooling or dependencies
- [ ] README script table, test counts and coverage numbers still accurate

**Gate**

- [ ] `./scripts/verify.sh` passes locally
- [ ] `act pull_request` run, if this touches `.github/workflows/`
- [ ] Commit messages follow the convention the `commit-msg` hook enforces

## Notes for the reviewer

<!-- Anything deliberately left out, a trade-off taken, or a place worth a closer look. -->
