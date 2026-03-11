" 界面主题
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
" 当没有文件参数且没有会话加载时，显示 startify（它会自动处理）
" NERDTree 不再自动打开，可以通过 <leader>n 手动打开

" Startify 配置
let g:startify_session_dir = '~/.vim/session'
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   Recent Files']   },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       },
    \ ]
let g:startify_bookmarks = [
    \ { 'i': '~/.config/nixpkgs/modules/common/vim/config/settings.vim' },
    \ { 'z': '~/.zshrc' },
    \ ]
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_change_to_dir = 1
let g:startify_fortune_use_unicode = 1
