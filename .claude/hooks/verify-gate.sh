#!/usr/bin/env bash
#
# Stop hook: refuses to end a turn that leaves unverified code behind.
#
# scripts/verify.sh records a hash of the source tree after a passing run. If
# the tree has changed since then, the same checks CI runs have not been run
# against the current code, and the turn is blocked with the command to run.
#
# Only code counts: the paths in scripts/workspace_hash.sh. Documentation,
# workflow and script edits end a turn freely.

set -uo pipefail

readonly payload="$(cat)"

# Claude Code sets stop_hook_active when the turn was already resumed by this
# hook once. Blocking again from there would loop forever.
if printf '%s' "$payload" | python3 -c '
import json, sys

try:
    data = json.load(sys.stdin)
except (json.JSONDecodeError, ValueError):
    sys.exit(1)

sys.exit(0 if data.get("stop_hook_active") else 1)
' 2>/dev/null; then
  exit 0
fi

readonly root="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$root" 2>/dev/null || exit 0
[[ -x scripts/workspace_hash.sh ]] || exit 0

changed="$(git status --porcelain -uall -- \
  lib test integration_test test_driver \
  pubspec.yaml analysis_options.yaml l10n.yaml 2>/dev/null)"

[[ -n "$changed" ]] || exit 0

current="$(scripts/workspace_hash.sh 2>/dev/null)" || exit 0
stamped="$(cat .dart_tool/verify_stamp 2>/dev/null || true)"

[[ "$current" == "$stamped" ]] && exit 0

CHANGED="$changed" python3 <<'PY'
import json, os

changed = [line for line in os.environ["CHANGED"].splitlines() if line.strip()]
shown = changed[:15]
listing = "\n".join(f"  {line}" for line in shown)
if len(changed) > len(shown):
    listing += f"\n  ... and {len(changed) - len(shown)} more"

reason = f"""Code changed in this turn but the quality gate has not passed against it.

Pending changes:
{listing}

Run the gate before finishing:

  ./scripts/verify.sh

It regenerates the localizations first and fails when that produces a diff, so
commit the regenerated output when an ARB file was touched.

If it fails, fix the cause and run it again. If the changes are deliberately
incomplete and the user asked to stop here, say so explicitly and stop."""

print(json.dumps({"decision": "block", "reason": reason}))
PY

exit 0
