{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    # Nix 管理所有插件
    plugins = with pkgs.vimPlugins; [
      vim-one
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
      builtins.readFile ./conf/settings.vim +
      builtins.readFile ./conf/ui.vim +
      builtins.readFile ./conf/git.vim +
      builtins.readFile ./conf/coc.vim +
      builtins.readFile ./conf/go.vim +
      builtins.readFile ./conf/shortcut/buffer.vim +
      builtins.readFile ./conf/shortcut/comment.vim +
      builtins.readFile ./conf/shortcut/coc.vim +
      builtins.readFile ./conf/shortcut/fzf.vim +
      builtins.readFile ./conf/shortcut/go.vim +
      builtins.readFile ./conf/shortcut/git.vim +
      builtins.readFile ./conf/shortcut/nerdtree.vim +
      builtins.readFile ./conf/shortcut/tagbar.vim +
      builtins.readFile ./conf/shortcut/window.vim +
      builtins.readFile ./conf/shortcut/term.vim;
  };
}
