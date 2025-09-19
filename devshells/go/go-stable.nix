{ pkgs }

pkgs.mkShell {
    buildInputs = with pkgs; [
    go
    gopls
    delve
    go-tools
    gotestsum
  ];
}