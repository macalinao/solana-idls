{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    git
    nixfmt-rfc-style
    biome

    # solana-cli
    anchor
    rustup
    cargo-expand
    cargo-nextest

    # Required for LiteSVM tests
    openssl
    pkg-config
    bun
  ];
}
