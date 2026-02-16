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
autocmd VimEnter * if argc() == 0 | NERDTree | endif
