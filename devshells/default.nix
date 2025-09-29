{ pkgs, fenix }:

{
  # 默认最小 shell
  default = pkgs.mkShell {
    buildInputs = with pkgs; [ zsh git ];
    shellHook = ''
      export EDITOR=vim
    '';
  };

  go = import ./go/go-stable.nix { inherit pkgs; };

  rust-wasm = import ./rust/rust-wasm.nix { inherit pkgs fenix; };

  node20 = import ./node/node20.nix { inherit pkgs; };
  node22 = import ./node/node22.nix { inherit pkgs; };

  java8 = import ./java/java8.nix { inherit pkgs; };
  java11 = import ./java/java11.nix { inherit pkgs; };
  java17 = import ./java/java17.nix { inherit pkgs; };

  deno = import ./deno/deno-stable.nix { inherit pkgs; };
}
