{ config, pkgs, lib, home-manager, user }:
let 
  homeDirectory = "${config.users.users.${user}.home}";

  packages = import ../../shared/packages.nix { inherit pkgs; };
  files = import ../../shared/files { inherit homeDirectory; };
  programs = import ../../shared/programs { inherit pkgs lib; };
in

{
  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = packages.homeManagerPackages;
        file = files;
        stateVersion = "23.11";
      };
      programs = programs;

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };
}