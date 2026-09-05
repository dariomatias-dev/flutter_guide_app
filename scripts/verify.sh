#!/usr/bin/env bash
#
# Runs the same quality gate CI enforces.
#
# The steps mirror .github/workflows/ci.yaml exactly, so a green run here means
# CI has no new reason to fail: regenerated localizations, ARB parity,
# formatting, analysis, tests and the coverage threshold.
#
# The gate only runs when the working tree has pending changes under the code
# it covers. Pass --all to run it regardless.
#
# On success the current workspace hash is recorded in .dart_tool/verify_stamp.
# The Stop hook reads it to tell whether the tree still matches a passing run.
#
# Generated code and localizations are regenerated on every invocation, and
# the run fails when that changed anything: CI regenerates from a clean
# checkout and rejects the build when the result differs from what was
# committed, which is a failure no other local check can see coming.
#
# Usage: scripts/verify.sh [--all] [--skip-tests]
#
#   --all         Run the gate even when nothing changed.
#   --skip-tests  Generation, formatting and analysis only. For a quick
#                 mid-change check, never as the final gate.

set -euo pipefail

export LC_ALL=C

readonly root="$(git rev-parse --show-toplevel)"
cd "$root"

readonly coverage_minimum=95

check_all=false
skip_tests=false

for arg in "$@"; do
  case "$arg" in
    --all) check_all=true ;;
    --skip-tests) skip_tests=true ;;
    -h|--help)
      sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "verify.sh: unknown option '$arg'" >&2
      exit 2
      ;;
  esac
done

if command -v fvm >/dev/null 2>&1 && [[ -f .fvmrc ]]; then
  flutter=(fvm flutter)
  dart=(fvm dart)
else
  flutter=(flutter)
  dart=(dart)
fi

step() {
  printf '\n\033[1m==> %s\033[0m\n' "$1"
}

changed_paths() {
  git status --porcelain -uall -- \
    lib test integration_test test_driver \
    pubspec.yaml analysis_options.yaml l10n.yaml build.yaml \
    | sed -e 's/^...//' -e 's/.* -> //' -e 's/^"//' -e 's/"$//'
}

if ! "$check_all" && [[ -z "$(changed_paths)" ]]; then
  echo "Nothing to verify: no pending changes under lib, test or the manifests."
  echo "Pass --all to run the full gate anyway."
  exit 0
fi

# Fingerprints the generated sources, tracked or not, so a regeneration that
# changes one can be told apart from one that confirms them all.
generated_fingerprint() {
  git ls-files -co --exclude-standard \
    -- 'lib/l10n/app_localizations*.dart' '**/*.g.dart' \
    | sort \
    | xargs -r sha1sum \
    | sha1sum
}

step "generate code and localizations"
before_generation="$(generated_fingerprint)"
"${dart[@]}" run build_runner build --delete-conflicting-outputs
"${flutter[@]}" gen-l10n

if [[ "$(generated_fingerprint)" != "$before_generation" ]]; then
  cat >&2 <<'MESSAGE'

Generated output was out of date and has just been refreshed. Review the
changes and commit them: CI regenerates from a clean checkout and fails when
the result differs from what the branch carries.
MESSAGE
  git status --porcelain -- 'lib/l10n/app_localizations*.dart' '**/*.g.dart' >&2
  exit 1
fi

step "localizations"
"$root/scripts/check_l10n.sh"

step "format"
"${dart[@]}" format --output=none --set-exit-if-changed \
  lib test integration_test

step "analyze"
"${flutter[@]}" analyze

if "$skip_tests"; then
  printf '\n\033[1mPartial run: tests were skipped, no stamp recorded.\033[0m\n'
  exit 0
fi

step "test"
"${flutter[@]}" test --coverage

step "coverage (minimum ${coverage_minimum}%)"
"$root/scripts/check_coverage.sh" coverage/lcov.info "$coverage_minimum"

mkdir -p .dart_tool
"$root/scripts/workspace_hash.sh" > .dart_tool/verify_stamp

printf '\n\033[1;32mAll checks passed.\033[0m\n'
