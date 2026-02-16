{ ... }:

{
  # Neovim 及其依赖已在 packages.nix 的 NVIM_PACKAGES 中安装
  # 这里管理 Neovim 配置文件

  # 将配置链接到 ~/.config/nvim/
  xdg.configFile."nvim" = {
    source = ./conf;
    recursive = true;
  };
}
