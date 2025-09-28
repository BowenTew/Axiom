{ user, config, pkgs, lib, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  homeDirectory = "/Users";
  sharedFiles = import ../shared/files { inherit config pkgs homeDirectory user; };
in 
lib.mkMerge [
  sharedFiles
  {}
]