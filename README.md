# Goreleaser CGO with Zig

This is a template repo for CGO cross-compilation with [goreleaser](https://github.com/goreleaser/goreleaser) and [Zig](https://ziglang.org/).

## What it does

Builds CGO binaries for **all 6 targets** from a single macOS runner:
- **Linux** (amd64, arm64) - statically linked with musl-libc
- **Windows** (amd64, arm64) - MinGW-w64 toolchain
- **macOS** (amd64, arm64) - native SDK

## How it works

Uses Zig as a drop-in replacement for C/C++ compilers via wrapper scripts (`scripts/zig-cc.sh` and `scripts/zig-cxx.sh`) that automatically select the correct target based on `GOOS`/`GOARCH` environment variables.

**Key benefits:**
- ✅ No Goreleaser Pro split-and-merge needed
- ✅ Single GitHub Actions runner (macOS)
- ✅ Fully static Linux binaries (musl-libc)
- ✅ True cross-compilation for all targets
- ✅ No need for multiple OS runners

## Local testing

Test individual targets locally:

```bash
# Linux amd64 (static)
GOOS=linux GOARCH=amd64 CGO_ENABLED=1 \
  CC=./scripts/zig-cc.sh CXX=./scripts/zig-cxx.sh \
  go build -v .

# Windows arm64
GOOS=windows GOARCH=arm64 CGO_ENABLED=1 \
  CC=./scripts/zig-cc.sh CXX=./scripts/zig-cxx.sh \
  go build -v .

# macOS arm64
GOOS=darwin GOARCH=arm64 CGO_ENABLED=1 \
  CC=./scripts/zig-cc.sh CXX=./scripts/zig-cxx.sh \
  go build -v .
```

Or test the full Goreleaser build locally:

```bash
goreleaser release --snapshot --clean
```
