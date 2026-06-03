#!/usr/bin/env bash
# Run the same checks as GitHub Actions locally:
#   ./tool/ci.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter is not on PATH" >&2
  exit 1
fi

echo "==> Fetching dependencies"
flutter pub get

echo "==> Checking formatting"
dart format --output=none --set-exit-if-changed lib test

echo "==> Running static analysis"
dart analyze --fatal-infos

echo "==> Running tests"
flutter test

echo "All CI checks passed."
