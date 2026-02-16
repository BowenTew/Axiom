{ config, pkgs, user, ... }:

{
  imports = [
    ./home-manager.nix
    ./homebrew.nix
    ./packages.nix
  ];
}
