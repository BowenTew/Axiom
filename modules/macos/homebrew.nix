{ config, pkgs, lib, user, ... }:

let
  packages = [];
  casks = [];
in
{
  config.homebrew = {
    enable = true;
    brews = packages;
    casks = casks;
  };
}
