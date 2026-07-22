#!/usr/bin/env bash
# Automatically drives the app through its main screens and saves a
# screenshot of each into screenshots/, for use in the README, Play
# Store listing, official website, etc.
#
# Usage:
#   scripts/screenshot.sh [device-id]
#
# Run `fvm flutter devices` to list available device ids. Defaults to
# the only connected device if there's just one.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

DEVICE_ARGS=()
if [[ "${1:-}" != "" ]]; then
  DEVICE_ARGS=(-d "$1")
fi

rm -rf screenshots
mkdir -p screenshots

fvm flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/screenshot_test.dart \
  "${DEVICE_ARGS[@]}"

echo "Screenshots saved in screenshots/"
