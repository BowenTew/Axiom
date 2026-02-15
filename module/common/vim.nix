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
    ];

    extraConfig = ''
      " =============================================================================
      " 基础设置
      " =============================================================================
      set encoding=utf-8
      set fileencoding=utf-8
      set number
      set relativenumber
      set cursorline
      set colorcolumn=80
      set laststatus=2
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set autoindent
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set clipboard=unnamedplus
      set mouse=a
      set hidden
      set updatetime=300
      set nobackup
      set nowritebackup
      set noswapfile
      let mapleader=" "
      let maplocalleader=" "

      " =============================================================================
      " 界面主题
      " =============================================================================
      set termguicolors
      set background=dark
      let g:gruvbox_material_background = 'medium'
      let g:gruvbox_material_enable_italic = 1
      colorscheme gruvbox-material
      let g:airline_theme = 'gruvbox_material'
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:NERDTreeShowHidden = 1
      let g:NERDTreeMinimalUI = 1
      autocmd VimEnter * if argc() == 0 | NERDTree | endif

      " =============================================================================
      " LSP (coc.nvim)
      " =============================================================================
      let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-pyright',
        \ 'coc-go',
        \ 'coc-rust-analyzer',
        \ 'coc-clangd'
        \ ]

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
      endfunction

      inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gr <Plug>(coc-references)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gy <Plug>(coc-type-definition)
      nnoremap <silent> K :call ShowDocumentation()<CR>
      nmap <leader>rn <Plug>(coc-rename)
      nmap <leader>f <Plug>(coc-format-selected)

      " =============================================================================
      " 快捷键映射
      " =============================================================================
      nnoremap <leader>e :NERDTreeToggle<CR>
      nnoremap <leader>f :NERDTreeFind<CR>
      nnoremap <leader>ff :Files<CR>
      nnoremap <leader>fg :Rg<CR>
      nnoremap <leader>fb :Buffers<CR>
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      nnoremap <S-h> :bprevious<CR>
      nnoremap <S-l> :bnext<CR>
      nnoremap <leader>bd :bdelete<CR>
      nnoremap <silent> <leader>h :nohlsearch<CR>
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
    '';
  };
}
