{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup
    rustc
    cargo
    clippy
    rust-analyzer
    rustfmt
  ];
  shellHook = ''
    echo "Rust devShell ready"
  '';
}
