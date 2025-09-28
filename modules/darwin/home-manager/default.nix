{ config, pkgs, lib, home-manager, user }:
let 
  packages = import ./packages.nix { inherit pkgs; };
  files = import ./files.nix { inherit user config pkgs lib; };
  programs = import ./programs.nix { inherit config pkgs lib; };
in

{
  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        inherit packages;
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