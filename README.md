# himalaya-tui-minimal

Minimal build of himalaya-tui for Arch Linux.

Source snapshot:

    1303e56f127788f2a0b41ac3b384c9580a201338e

## Features

Enabled:

- IMAP
- SMTP
- rustls-ring

Disabled:

- JMAP
- Maildir

This configuration is enough for the tested Gmail and university email
accounts using IMAP and SMTP.

## Build dependencies

- rust
- cargo

Rust and Cargo are only required to compile the application.

## Runtime dependencies

The tested binary dynamically links only against the normal system runtime:

- glibc
- gcc-libs
- libm

The tested minimal build does not dynamically depend on OpenSSL or GPGME.

## Build

From the himalaya-tui source directory:

    cargo build \
      --release \
      --locked \
      --no-default-features \
      --features imap,smtp,rustls-ring

The resulting binary is:

    target/release/himalaya-tui

It can be stripped with:

    strip --strip-unneeded target/release/himalaya-tui

## Result

Previous build:

    ~11 MiB

Minimal build:

    ~9.8 MiB

Check the enabled features with:

    himalaya-tui --version

Expected features:

    +imap +smtp +rustls-ring

JMAP and Maildir should not appear.

## Configuration

himalaya-tui uses:

    ~/.config/himalaya/config.toml

The tested setup supports IMAP and SMTP authentication, including XOAUTH2.

Do NOT commit:

- config.toml
- OAuth tokens
- passwords
- secret-tool data
- other credentials
