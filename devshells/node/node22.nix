{ pkgs }:

pkgs.mkShell {
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
}