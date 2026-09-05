#!/usr/bin/env bash
#
# Fails when line coverage in an lcov report falls below a minimum.
#
# Two kinds of file are excluded. Generated sources mirror hand-written
# declarations and nothing in them can be covered by a test of the app. The
# catalog samples under lib/src/features/catalog/data/samples/ are the
# teaching material the app renders to the user: nearly 7000 lines of it,
# which drag the reported figure from 95% to 24% without saying anything
# about the app's own code.
#
# Usage: scripts/check_coverage.sh <lcov-file> <minimum-percent>

set -euo pipefail

export LC_ALL=C

readonly lcov_file="${1:?usage: check_coverage.sh <lcov-file> <minimum-percent>}"
readonly minimum="${2:?usage: check_coverage.sh <lcov-file> <minimum-percent>}"

if [[ ! -f "$lcov_file" ]]; then
  echo "No coverage report at $lcov_file. Run 'flutter test --coverage' first." >&2
  exit 1
fi

awk -v minimum="$minimum" '
  /^SF:/ {
    file = substr($0, 4)
    skip = (file ~ /\.g\.dart$/) ||
           (file ~ /lib\/l10n\//) ||
           (file ~ /lib\/src\/features\/catalog\/data\/samples\//)
    next
  }
  /^DA:/ {
    if (skip) next
    split(substr($0, 4), fields, ",")
    total++
    if (fields[2] > 0) hit++
  }
  END {
    if (total == 0) {
      print "No coverable lines found. Is the report empty?" > "/dev/stderr"
      exit 1
    }
    percent = 100 * hit / total
    printf "Line coverage: %.1f%% (%d/%d), minimum %s%%\n", percent, hit, total, minimum
    if (percent + 0.05 < minimum) {
      printf "Coverage fell below the minimum.\n" > "/dev/stderr"
      exit 1
    }
  }
' "$lcov_file"
