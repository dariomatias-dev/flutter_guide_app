#!/usr/bin/env bash
#
# PostToolUse hook: formats a Dart file right after the agent writes it.
#
# Formatting is the one check in the gate with a single correct answer, so it
# is fixed automatically rather than reported. Generated files are left alone:
# gen-l10n rewrites them and formats them itself.
#
# Reads the hook payload on stdin, never blocks, never fails the tool call.

set -uo pipefail

readonly payload="$(cat)"

file="$(printf '%s' "$payload" | python3 -c '
import json, sys

try:
    data = json.load(sys.stdin)
except (json.JSONDecodeError, ValueError):
    sys.exit(0)

print(data.get("tool_input", {}).get("file_path", ""))
' 2>/dev/null)"

[[ -n "$file" && -f "$file" ]] || exit 0
[[ "$file" == *.dart ]] || exit 0
[[ "$file" == *.g.dart ]] && exit 0
[[ "$file" == */lib/l10n/app_localizations*.dart ]] && exit 0

root="$(git -C "$(dirname "$file")" rev-parse --show-toplevel 2>/dev/null)" || exit 0
[[ -n "$root" ]] || exit 0

cd "$root" || exit 0

if command -v fvm >/dev/null 2>&1 && [[ -f .fvmrc ]]; then
  fvm dart format "$file" >/dev/null 2>&1
else
  dart format "$file" >/dev/null 2>&1
fi

exit 0
