{ pkgs, config, homeDirectory, user, ... }:

let
  XDG_CONFIG_HOME = "${homeDirectory}/${user}/.config";
in
{
  # Neovim配置文件映射
  "${XDG_CONFIG_HOME}/nvim" = {
    source = ./dotfiles/nvim;
    recursive = true;
  };

  # Kitty配置文件映射
  "${XDG_CONFIG_HOME}/kitty" = {
    source = ./dotfiles/kitty;
    recursive = true;
  };
}
