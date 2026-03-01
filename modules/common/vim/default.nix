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
      vim-go
      tagbar
    ];

    # 从多个文件加载配置
    extraConfig = 
      builtins.readFile ./config/settings.vim +
      builtins.readFile ./config/ui.vim +
      builtins.readFile ./config/git.vim +
      builtins.readFile ./config/coc.vim +
      builtins.readFile ./config/go.vim +
      builtins.readFile ./config/shortcut/buffer.vim +
      builtins.readFile ./config/shortcut/comment.vim +
      builtins.readFile ./config/shortcut/coc.vim +
      builtins.readFile ./config/shortcut/fzf.vim +
      builtins.readFile ./config/shortcut/go.vim +
      builtins.readFile ./config/shortcut/git.vim +
      builtins.readFile ./config/shortcut/nerdtree.vim +
      builtins.readFile ./config/shortcut/tagbar.vim +
      builtins.readFile ./config/shortcut/window.vim;
  };
}
