{ ... }:

{
  imports = [
    ../common/identity.nix
    ./home-manager.nix
    ./homebrew.nix
    ./packages.nix
  ];
}
