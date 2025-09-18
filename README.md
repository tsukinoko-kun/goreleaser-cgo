# Goreleaser CGO

This is a template repo for CGO with [goreleaser](https://github.com/goreleaser/goreleaser).

It builds binaries for Linux, Windows and macOS. All binaries are compiled on the target OS and CPU architecture.

Linux builds use Zig to statically link musl-libc.

Windows ARM64 uses Zig for cross-compilation from x86_64 to ARM64.

macOS uses Apple Clang with dynamic linking.
