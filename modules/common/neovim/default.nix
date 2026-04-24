{ config, lib, inputs, ... }:

{
  # Neovim 及其依赖已在 packages.nix 的 NVIM_PACKAGES 中安装
  # 这里管理 Neovim 配置文件

  # 从 flake input 引入配置，链接到 ~/.config/nvim/
  xdg.configFile."nvim" = {
    source = inputs.neovim-config;
    recursive = true;
    force = true;
  };

  # 切换配置时清除 Neovim Lua 缓存，避免缓存导致的模块加载问题
  home.activation.clearNvimCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${config.home.homeDirectory}/.cache/nvim/luac"
  '';
}
