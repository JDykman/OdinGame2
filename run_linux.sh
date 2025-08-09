#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Build
"$SCRIPT_DIR/build_linux.sh"

# Ensure FMOD linux libs are discoverable and versioned symlinks exist
CORE_LIB_DIR="$SCRIPT_DIR/sauce/bald/sound/fmod/core/lib/linux"
STUDIO_LIB_DIR="$SCRIPT_DIR/sauce/bald/sound/fmod/studio/lib/linux"

ensure_link() {
  local dir="$1"; local base="$2"; local ver="${3:-14}"
  if [[ -f "$dir/$base.so" && ! -e "$dir/$base.so.$ver" ]]; then
    ln -sf "$dir/$base.so" "$dir/$base.so.$ver"
  fi
}

ensure_link "$CORE_LIB_DIR" libfmod 14
ensure_link "$CORE_LIB_DIR" libfmodL 14
ensure_link "$STUDIO_LIB_DIR" libfmodstudio 14
ensure_link "$STUDIO_LIB_DIR" libfmodstudioL 14

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}:$CORE_LIB_DIR:$STUDIO_LIB_DIR"

# Run
"$SCRIPT_DIR/build/linux_debug/game"
