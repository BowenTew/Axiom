{
  description = "Node.js 22 project template";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
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
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs_22
              corepack
              nodePackages.pnpm
              nodePackages.yarn
              nodePackages.typescript
            ];
            shellHook = ''
              export PATH="$PWD/node_modules/.bin:$PATH"
              corepack enable || true
            '';
          };
        });
    };
}
