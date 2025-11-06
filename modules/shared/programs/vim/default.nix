{ pkgs, ... }:

{
  enable = true;                # 启用 vim 模块

  # 使用 Nix 管理所有插件
  plugins = with pkgs.vimPlugins; [
    gruvbox-material
    vim-airline
    vim-airline-themes
    nerdtree
    nerdtree-git-plugin
    vim-devicons
    vim-gitgutter
    markdown-preview-nvim
    vim-snippets
    coc-nvim
  ];

  # 把文件内容原样读进来当成 extraConfig
  extraConfig = builtins.readFile ./vimrc;
}