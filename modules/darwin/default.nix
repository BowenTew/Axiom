{ config, pkgs, lib, home-manager, user, ... }:

let
  darwinHomeManagerConfig = import ./home-manager/default.nix { inherit config pkgs lib home-manager user; };
  darwinNixHomebrewConfig = import ./nix-homebrew/default.nix { inherit config pkgs lib; };
  sharedPackages = import ../shared/packages.nix { inherit pkgs; };
in
{
  environment.systemPackages = sharedPackages.systemPackages;

  imports = [ 
    darwinHomeManagerConfig
    darwinNixHomebrewConfig
  ];
}
