# solana-cpis

Pre-generated CPI clients for Quarry Protocol programs using Anchor's `declare_program!` macro.

## Overview

This crate provides ready-to-use CPI clients for all Quarry Protocol programs. It uses the processed IDLs from this repository to generate type-safe Rust interfaces via `declare_program!`.

## Included Programs

- `quarry_merge_mine` - Multi-token staking rewards program
- `quarry_mine` - Core staking rewards distribution program  
- `quarry_mint_wrapper` - Token minting wrapper program
- `quarry_operator` - Operator delegation program
- `quarry_redeemer` - Token redemption program
- `quarry_registry` - Registry for Quarry programs

## Usage

While you can use this crate directly, **the recommended approach** is to copy only the IDL files you need from the `idls/` directory and use `declare_program!` in your own project. This gives you more control and reduces dependencies.

### Direct Usage (Not Recommended)

```rust
use solana_cpis::quarry_mine;

// Use the CPI client
quarry_mine::cpi::stake(ctx, amount)?;
```

### Recommended Usage

1. Copy the specific IDL file(s) you need from `idls/`
2. Use `declare_program!` in your own code
3. Only include the programs you actually need

This approach reduces binary size and compilation time.

## Feature Flags

- `cpi` (default): Enables CPI functionality
- `no-entrypoint`: Disables the default entrypoint for use in CPI contexts
- `no-idl`: Excludes IDL generation
- `no-log-ix-name`: Disables instruction name logging
- `idl-build`: Enables IDL build features

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](../../LICENSE.txt) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.