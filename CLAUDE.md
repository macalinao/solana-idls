# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Build
```bash
# Build all packages
bun run build

# Build and watch for changes
bun run build:watch

# Build Rust crates
cargo build

# Build release version
cargo build --release
```

### Lint and Format
```bash
# Run linting and formatting checks
bun run lint

# Auto-fix linting and formatting issues
bun run lint:fix

# Format code with Biome
biome check --write
```

### Test
```bash
# Run all tests
bun run test

# Run end-to-end tests (builds first)
bun run test:e2e

# Run Rust tests
cargo test

# Run tests with cargo-nextest
cargo nextest run
```

### Development
```bash
# Clean build artifacts
bun run clean

# Watch mode for development
bun run watch

# Generate code from IDLs
bun run codegen

# Process IDL files (updates from source-idls/ to idls/)
./scripts/process_idls.sh
```

### Publishing
```bash
# Create a changeset
bun run changeset

# Version packages
bun run changeset:version

# Publish packages
bun run changeset:publish
```

## Architecture

This repository maintains a registry of Solana program IDLs and generates CPI (Cross-Program Invocation) crates for Anchor programs. The key components are:

### Directory Structure
- `source-idls/`: Original IDL files for Quarry programs
- `idls/`: Processed IDL files with metadata (addresses) added
- `crates/`: Rust CPI crates generated from IDLs
  - `quarry-mine-cpi/`: CPI crate for Quarry Mine program
  - `quarry-merge-mine-cpi/`: CPI crate for Quarry Merge Mine program
- `packages/`: TypeScript/JavaScript packages (currently empty, workspace configured)
- `scripts/`: Processing scripts for IDL conversion

### IDL Processing Flow
1. Source IDL files are stored in `source-idls/`
2. Program addresses are defined in `addresses.toml`
3. `scripts/process_idls.sh` reads addresses and adds metadata to IDLs
4. Processed IDLs are saved to `idls/` with proper formatting

### CPI Crate Generation
The Rust crates use Anchor's `declare_program!` macro to generate type-safe interfaces for cross-program invocations. Each crate corresponds to a Solana program and provides Rust bindings for interacting with that program.

### Development Environment
- Uses `devenv.nix` for consistent development environment
- Includes Solana CLI, Anchor, and Rust toolchain
- Uses Bun as the JavaScript runtime and package manager
- Biome for code formatting and linting