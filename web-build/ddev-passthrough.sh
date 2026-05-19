#!/usr/bin/env bash
# In-container replacement for /usr/local/bin/ddev.
# Dispatches `ddev <sub>` to /mnt/ddev-global-cache/global-commands/web/<sub>
# when that file is executable; otherwise exits 127 with a clear error.
# Project-local commands (/mnt/ddev_config/commands/web/) and host-only
# subcommands (start/stop/pull/describe/...) are NOT proxied.

set -eu -o pipefail

GLOBAL_DIR=/mnt/ddev-global-cache/global-commands/web

if [ $# -eq 0 ]; then
  echo "Usage: ddev <command> [args...]   (in-container passthrough scoped to $GLOBAL_DIR)" >&2
  exit 64
fi

sub="$1"; shift
if [ -x "$GLOBAL_DIR/$sub" ]; then
  exec "$GLOBAL_DIR/$sub" "$@"
fi

echo "ddev: '$sub' is not available inside the web container (host-only, or not a global custom command)" >&2
exit 127
