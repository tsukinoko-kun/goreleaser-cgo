#!/usr/bin/env bash
set -euo pipefail
# Just forward to zig-cc with C++ frontend.
exec "$(dirname "$0")/zig-cc.sh" "$@"
