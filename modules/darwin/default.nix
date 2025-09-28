{ config, pkgs, lib, home-manager, ... }:

let
  user = "moonshot";
  darwinHomeManagerConfig = import ./home-manager/default.nix { inherit config pkgs lib home-manager user; };
  darwinNixHomebrewConfig = import ./nix-homebrew/default.nix { inherit config pkgs lib; };
in
{
  imports = [ 
    darwinHomeManagerConfig
    darwinNixHomebrewConfig
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
