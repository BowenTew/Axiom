# Vim

`modules/common/vim/default.nix` 配置了完整的 Vim 开发环境。

## 插件列表

| 插件 | 功能 |
|------|------|
| `vim-one` | One 主题 |
| `gruvbox-material` | Gruvbox Material 主题 |
| `vim-airline` | 状态栏 |
| `nerdtree` | 文件树 |
| `nerdtree-git-plugin` | NERDTree Git 状态 |
| `fzf-vim` | 模糊查找 |
| `vim-fugitive` | Git 集成 |
| `vim-gitgutter` | Git diff 标记 |
| `coc-nvim` | LSP/补全引擎 |
| `vim-commentary` | 快速注释 |
| `auto-pairs` | 自动括号配对 |
| `vim-polyglot` | 多语言语法高亮 |
| `vim-startify` | 启动页 |
| `vim-go` | Go 语言支持 |
| `tagbar` | 代码大纲 |

## 配置结构

Vim 配置分散在多个文件中：

```
vim/
├── default.nix          # 主配置，导入所有插件和配置
└── conf/
    ├── settings.vim     # 基础设置
    ├── ui.vim           # 界面配置
    ├── git.vim          # Git 相关
    ├── coc.vim          # CoC 配置
    ├── go.vim           # Go 开发
    └── shortcut/        # 快捷键定义
        ├── buffer.vim
        ├── coc.vim
        ├── comment.vim
        ├── fzf.vim
        ├── go.vim
        ├── git.vim
        ├── nerdtree.vim
        ├── tagbar.vim
        ├── term.vim
        └── window.vim
```
