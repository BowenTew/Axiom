" ============================================
" Git 配置 - 类似 VSCode 的 Diff 体验
" ============================================

" --------------------------------------------
" vim-gitgutter 配置（侧边栏标记 + 行内预览）
" --------------------------------------------

" 始终显示符号列（避免抖动）
set signcolumn=yes

" 实时更新（比默认更快）
set updatetime=100

" 高亮设置
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 1

" 符号样式（类似 VSCode）
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '{'
let g:gitgutter_sign_modified_removed = '~'

" 预览窗口样式
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_close_preview_on_escape = 1

" --------------------------------------------
" vim-gitgutter 快捷键（行内 Diff 预览）
" --------------------------------------------

" 预览当前 hunk（类似 VSCode 点击行看修改）
nnoremap <leader>ghp :GitGutterPreviewHunk<CR>

" 暂存当前 hunk（类似 VSCode 的 + 按钮）
nnoremap <leader>ghs :GitGutterStageHunk<CR>

" 撤销当前 hunk（类似 VSCode 的撤销）
nnoremap <leader>ghr :GitGutterUndoHunk<CR>

" 跳转到上一个/下一个修改
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" 查看当前文件的所有 hunks（列表）
nnoremap <leader>ghl :GitGutterQuickFix<CR>:copen<CR>

" 切换行内 blame（类似 VSCode 的 GitLens）
nnoremap <leader>gb :GitGutterToggle<CR>

" --------------------------------------------
" vim-fugitive 快捷键（分屏 Diff）
" --------------------------------------------

" 打开当前文件的 diff（类似 VSCode 点击文件看修改）
nnoremap <leader>gd :Gdiffsplit<CR>

" 打开当前文件的 diff（与指定分支比较）
nnoremap <leader>gD :Gdiffsplit master<CR>

" 打开 Git 状态面板（类似 VSCode Source Control）
nnoremap <leader>gs :Git<CR>

" 查看当前文件的历史（类似 VSCode Timeline）
nnoremap <leader>gl :0Glog<CR>

"  blame 当前行（类似 VSCode GitLens）
nnoremap <leader>gm :Git blame<CR>

" 快速提交
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gC :Git commit --amend<CR>

" Push / Pull
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git pull<CR>

" 查看所有修改的文件列表
nnoremap <leader>gS :Git status<CR>

" --------------------------------------------
" 增强：类似 VSCode 的 Diff 视图快捷键
" --------------------------------------------

" 在 diff 模式下，方便切换
" ]c / [c 已经用于跳转到 hunk

" diff 模式下：获取远端版本（使用他们的）
nnoremap <leader>do :diffget //2<CR>:diffupdate<CR>
" diff 模式下：获取本地版本（使用我们的）
nnoremap <leader>dp :diffget //3<CR>:diffupdate<CR>

" 关闭 diff 视图
nnoremap <leader>dq :diffoff!<CR>:q<CR>

" --------------------------------------------
" 可视化设置
" --------------------------------------------

" diff 高亮颜色（更接近 VSCode）
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=#98c379 guibg=#3c4c3c
highlight DiffChange cterm=bold ctermfg=11 ctermbg=24 gui=none guifg=#e5c07b guibg=#4c4c3c
highlight DiffDelete cterm=bold ctermfg=9  ctermbg=52 gui=none guifg=#e06c75 guibg=#4c3c3c
