#!/bin/bash
# Thin shim so the legacy URL still works:
#   curl -sSL https://raw.githubusercontent.com/.../main/update.sh | bash
#
# The real updater now lives at scripts/update.sh.
exec "$(dirname "${BASH_SOURCE[0]}")/scripts/update.sh" "$@"
