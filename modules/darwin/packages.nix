{ pkgs }:

with pkgs;
let sharedPackages = import ../shared/packages.nix { inherit pkgs; }; in
sharedPackages ++ []
