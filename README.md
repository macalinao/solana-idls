# solana-idls

A comprehensive registry of Solana program IDLs with auto-generated CPI crates for seamless cross-program invocations.

## Why This Project?

The Solana ecosystem has grown rapidly, but integrating with various programs through CPIs remains challenging:

1. **IDL Versioning Issues**: Many popular Solana programs have outdated or incompatible IDLs that don't work with modern Anchor versions
2. **CPI Integration Complexity**: Developers need to manually generate and maintain CPI clients for each program they interact with
3. **Namespace Conflicts**: Original IDLs often have naming conflicts that prevent them from working with Anchor's `declare_program!` macro
4. **Scattered Documentation**: Finding the correct program addresses and understanding integration patterns requires searching through multiple repositories

This project solves these problems by providing:

- **Updated IDLs**: All IDLs are modified and tested to work with the latest Anchor version
- **Pre-generated CPI Crates**: Ready-to-use Rust crates for cross-program invocations
- **Standardized Integration**: Consistent patterns for integrating with Solana programs
- **Central Registry**: One place to find program addresses, IDLs, and integration examples

## Features

- 📦 **Pre-built CPI Crates**: Import and use immediately in your Anchor programs
- 🔄 **Auto-generated from IDLs**: Type-safe interfaces generated from program IDLs
- 🛠️ **Anchor Compatible**: Modified IDLs that work seamlessly with `declare_program!`
- 📍 **Program Registry**: Centralized registry of program addresses and metadata
- 🚀 **Modern Tooling**: Built with Bun, TypeScript, and the latest Rust toolchain

## Project Structure

```
├── source-idls/        # Original IDL files
├── idls/              # Processed IDLs with metadata
├── crates/            # Generated Rust CPI crates
│   └── solana-cpis/   # Aggregated crate with all CPIs
├── packages/          # TypeScript packages (coming soon)
└── scripts/           # IDL processing scripts
```

## Usage

1. Copy the IDL file you need from the `idls/` directory into your project
2. Use Anchor's `declare_program!` macro in your code:

```rust
use anchor_lang::prelude::*;

// Declare the external program using the IDL
declare_program!(quarry_mine);

#[program]
pub mod my_program {
    use super::*;

    pub fn stake_in_quarry(ctx: Context<StakeInQuarry>, amount: u64) -> Result<()> {
        // Use the generated CPI client
        quarry_mine::cpi::stake(
            ctx.accounts.into(),
            amount,
        )?;
        Ok(())
    }
}
```

### Example: Adding an IDL to Your Project

```bash
# Copy the IDL to your project
cp path/to/solana-idls/idls/quarry_mine.json your-project/idls/

# In your Rust code, use declare_program! with the IDL
```

The IDLs in this repository are pre-processed and tested to work seamlessly with `declare_program!`, saving you from dealing with namespace conflicts and compatibility issues.

## Development

### Prerequisites

- Rust and Cargo
- Solana CLI tools
- Anchor Framework
- Bun runtime

### Building

```bash
# Install dependencies
bun install

# Build all crates
cargo build

# Generate CPI crates from IDLs
bun run codegen

# Process IDL files
./scripts/process_idls.sh
```

### Adding New Programs

1. Add the original IDL to `source-idls/`
2. Add program address to `addresses.toml`
3. Run `./scripts/process_idls.sh` to process the IDL
4. Generate CPI crate with appropriate tooling
5. Add the crate to the workspace

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Some ways to contribute:

- Add new program IDLs
- Update existing IDLs to newer versions
- Improve documentation and examples
- Add TypeScript codegen support

## License

Apache-2.0. See [LICENSE.txt](LICENSE.txt) for details.
