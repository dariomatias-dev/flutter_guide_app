#!/usr/bin/env bash
#
# Prints a hash of every source file the quality gate cares about, in its
# current working-tree state.
#
# scripts/verify.sh records this hash after a successful run, and the Stop hook
# in .claude/settings.json compares against it: an identical hash means the
# tree hasn't changed since the gate last passed, so there is nothing to
# re-verify. Build outputs, coverage reports and other ignored paths are left
# out, since they change on every run and would invalidate the stamp
# immediately.
#
# Usage: scripts/workspace_hash.sh

set -euo pipefail

export LC_ALL=C

cd "$(git rev-parse --show-toplevel)"

# The same paths scripts/verify.sh derives its scope from: the code the gate
# actually compiles, analyses and tests. Documentation, workflows and scripts
# are deliberately absent, so editing a README never asks for a test run.
readonly sources=(
  lib
  test
  integration_test
  test_driver
  pubspec.yaml
  analysis_options.yaml
  l10n.yaml
)

{
  # The commit the tree sits on. Without it a clean checkout hashes the same
  # on every branch, and a stamp recorded before a checkout would still look
  # current afterwards.
  git rev-parse HEAD

  git status --porcelain -uall -- "${sources[@]}"

  git ls-files --modified --others --exclude-standard -z -- "${sources[@]}" \
    | sort -z \
    | xargs -0 --no-run-if-empty sha1sum 2>/dev/null \
    || true
} | sha1sum | cut -d' ' -f1
