#!/usr/bin/env bash
set -euo pipefail

GOOS="${GOOS:-}"
GOARCH="${GOARCH:-}"

case "${GOOS}/${GOARCH}" in
  linux/amd64)   ZT="x86_64-linux-musl";;
  linux/arm64)   ZT="aarch64-linux-musl";;
  windows/amd64) ZT="x86_64-windows-gnu";;
  windows/arm64) ZT="aarch64-windows-gnu";;
  darwin/amd64)  ZT="x86_64-macos";;
  darwin/arm64)  ZT="aarch64-macos";;
  *) echo "Unsupported target: ${GOOS}/${GOARCH}" >&2; exit 1;;
esac

EXTRA=()

# Linux: request fully static linking.
if [[ "${GOOS}" == "linux" ]]; then
  EXTRA+=("-static")
fi

# macOS: require an SDK (on macOS runner, auto-detect via xcrun).
if [[ "${GOOS}" == "darwin" ]]; then
  SDK="${MACOS_SDK_PATH:-}"
  if [[ -z "${SDK}" ]]; then
    if command -v xcrun >/dev/null 2>&1; then
      SDK="$(xcrun --sdk macosx --show-sdk-path)"
    fi
  fi
  if [[ -z "${SDK}" ]]; then
    echo "Set MACOS_SDK_PATH to a valid MacOSX.sdk when cross-compiling on Linux." >&2
    exit 1
  fi
  # Provide explicit paths to SDK libraries and frameworks for Zig linker
  EXTRA+=("-L${SDK}/usr/lib" "-F${SDK}/System/Library/Frameworks" "-isysroot" "${SDK}")
fi

# Use proper array expansion that handles empty arrays
if [ ${#EXTRA[@]} -eq 0 ]; then
  exec zig cc -target "${ZT}" "$@"
else
  exec zig cc -target "${ZT}" "${EXTRA[@]}" "$@"
fi
