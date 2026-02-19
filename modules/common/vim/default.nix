{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    # Nix 管理所有插件
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
      vim-airline
      vim-airline-themes
      nerdtree
      nerdtree-git-plugin
      fzf-vim
      vim-fugitive
      vim-gitgutter
      coc-nvim
      vim-commentary
      auto-pairs
      vim-polyglot
      vim-startify
    ];

    # 从多个文件加载配置
    extraConfig = 
      builtins.readFile ./config/settings.vim +
      builtins.readFile ./config/ui.vim +
      builtins.readFile ./config/git.vim +
      builtins.readFile ./config/coc.vim +
      builtins.readFile ./config/keymaps.vim;
  };
}
