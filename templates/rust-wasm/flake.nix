{
  description = "Rust + WebAssembly project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          rustWasmToolchain = with fenix.packages.${system};
            combine [
              stable.toolchain
              targets.wasm32-unknown-unknown.stable.rust-std
            ];
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              rustWasmToolchain
              wasm-pack
              binaryen
              wabt
              llvmPackages.lld
              git
              nodejs_20
              rust-analyzer
            ];

            CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";

            shellHook = ''
              export EDITOR=vim
              export WASM_PACK_CACHE_DIR="$HOME/.wasm-pack"
              export PATH="${pkgs.llvmPackages.lld}/bin:$PATH"

              echo "🦀 Rust + WebAssembly devShell ready"
            '';
          };
        });
    };
}
