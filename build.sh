#!/bin/bash
set -euo pipefail

DEPS=(
    rust
)

MISSING=()

for pkg in "${DEPS[@]}"; do
    pacman -Q "$pkg" &>/dev/null || MISSING+=("$pkg")
done

if ((${#MISSING[@]})); then
    echo "Installing missing dependencies:"
    printf '  %s\n' "${MISSING[@]}"
    sudo pacman -S --needed "${MISSING[@]}"
fi

rm -rf dist
mkdir -p dist

cd src

cargo build \
    --release \
    --locked \
    --no-default-features \
    --features imap,smtp,rustls-ring

cd ..

cp src/target/release/himalaya-tui dist/

strip --strip-unneeded dist/himalaya-tui

echo
echo "Build complete:"
du -h dist/himalaya-tui
