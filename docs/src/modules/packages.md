# Packages

`modules/macos/packages.nix` 定义了系统级和用户级安装的所有包。

## 包分组

### Go 开发

| 包 | 说明 |
|----|------|
| `go` | Go 编译器 |
| `gotags` | ctags for Go |
| `gopls` | Go LSP |
| `delve` | Go 调试器 |
| `go-tools` | Go 工具集 |
| `gotestsum` | 测试输出美化 |

### Rust 开发

| 包 | 说明 |
|----|------|
| `rustc` | Rust 编译器 |
| `cargo` | 包管理器 |
| `clippy` | Linter |
| `rust-analyzer` | LSP |
| `rustfmt` | 格式化 |

### JavaScript 开发

| 包 | 说明 |
|----|------|
| `nodejs_22` | Node.js |
| `pnpm` | 包管理器 |

### Python

| 包 | 说明 |
|----|------|
| `uv` | 极速 Python 包管理器 |
| `python3` | Python 解释器 |

### Lua

| 包 | 说明 |
|----|------|
| `lua` | Lua 解释器 |
| `luarocks` | Lua 包管理器 |

### 基础开发工具

| 包 | 说明 |
|----|------|
| `git`, `git-lfs`, `tig` | 版本控制 |
| `ripgrep`, `fd`, `fzf` | 搜索工具 |
| `universal-ctags` | 代码标签 |
| `neovim` | 编辑器 |
| `gcc`, `gnumake` | 编译工具 |
| `lazygit` | TUI Git |
| `chezmoi` | 点文件管理 |
| `helix` | 模态编辑器 |
| `dockerfile-language-server-nodejs` | Dockerfile LSP |

### 终端工具

| 包 | 说明 |
|----|------|
| `tmux` | 终端复用器 |
| `kitty` | GPU 终端 |

### 系统工具

| 包 | 说明 |
|----|------|
| `bat` | 增强 cat |
| `tree` | 目录树 |
| `coreutils` | GNU 核心工具 |
| `zip`, `unzip` | 压缩工具 |

### 字体

| 包 | 说明 |
|----|------|
| `hack-font` | Hack 字体 |
| `meslo-lgs-nf` | Meslo Nerd Font |
| `noto-fonts` | Noto 字体 |
| `noto-fonts-emoji` | Emoji 字体 |
| `nerd-fonts.roboto-mono` | Roboto Mono Nerd Font |
| `powerline` | Powerline 字体 |
