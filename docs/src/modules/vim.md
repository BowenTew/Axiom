# Vim

> ⚠️ 当前配置使用 Neovim（`pkgs.neovim`）作为编辑器，通过 `modules/common/packages.nix` 安装。Vim 模块文档保留作为历史参考。
>
> 如果你需要自定义 Neovim 配置，建议：
> 1. 在 `modules/common/` 下创建 `neovim.nix`
> 2. 在 `modules/common/default.nix` 中导入
> 3. 或使用独立的 Neovim 配置仓库（如 [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)）

## 当前状态

仓库中**没有** `modules/common/vim/` 目录。`modules/common/default.nix` 仅导入：
- `git.nix`
- `zsh.nix`
- `tmux.nix`

Neovim 作为普通包通过 `modules/common/packages.nix` 安装，不附带额外的 Nix 配置。
