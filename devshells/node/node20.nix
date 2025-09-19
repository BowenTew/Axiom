{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    corepack    
          
    nodePackages.pnpm 
    nodePackages.yarn
    nodePackages.typescript
  ];
  shellHook = ''
    export PATH="$PWD/node_modules/.bin:$PATH"
    corepack enable || true
    echo "Node.js 20 devShell ready"
  '';
}
