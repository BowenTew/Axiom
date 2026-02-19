" 快捷键映射
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

nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gs :Git diff --cached<CR>

" 撤销当前文件的修改，类似gco
nnoremap <leader>gr :Gread<CR>
" 提交当前文件修改到暂存
nnoremap <leader>gw :Gwrite<CR>

" 查看当前 hunk 的详细改动
nnoremap <leader>ghb :Git blame<CR>
" 预览当前 hunk（类似 VSCode 点击行看修改）
nnoremap <leader>ghp :GitGutterPreviewHunk<CR>
" 暂存当前 hunk（类似 VSCode 的 + 按钮）
nnoremap <leader>ghs :GitGutterStageHunk<CR>
" 撤销当前 hunk（类似 VSCode 的撤销）
nnoremap <leader>ghr :GitGutterUndoHunk<CR>
nnoremap <leader>ghl :GitGutterQuickFix<CR>:copen<CR>

nnoremap <leader>gcl :Gclog -- %<CR>

nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" 处理conflict，使用目标分支
nnoremap <leader>do :diffget //2<CR>:diffupdate<CR>
" 处理conflict，使用本地分支
nnoremap <leader>dp :diffget //3<CR>:diffupdate<CR>
" 关闭 diff 视图
nnoremap <leader>dq :diffoff!<CR>:q<CR>
