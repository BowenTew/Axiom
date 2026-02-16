{ pkgs, ... }:

{
  xdg.configFile."kitty" = {
    source = ./conf;
    recursive = true;
  };
}
