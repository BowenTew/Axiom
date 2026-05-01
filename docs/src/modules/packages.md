# Packages

包定义分散在两个文件中：

- **`modules/common/packages.nix`** — 用户级包（通过 Home Manager 安装）
- **`modules/macos/packages.nix`** — 遗留文件（当前未被导入）

## 用户级包 (modules/common/packages.nix)

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

通过 `fenix` 提供完整工具链：

| 组件 | 说明 |
|------|------|
| `cargo` | 包管理器 |
| `clippy` | Linter |
| `rustc` | 编译器 |
| `rustfmt` | 格式化 |
| `rust-src` | 标准库源码（rust-analyzer 需要） |
| `rust-analyzer` | LSP |

使用 USTC 镜像加速下载：
```nix
fenixPkgs.toolchainOf {
  channel = "stable";
  date = "2025-09-18";
  sha256 = "sha256-SJwZ8g0zF2WrKDVmHrVG3pD2RGoQeo24MEXnNx5FyuI=";
  root = "https://mirrors.ustc.edu.cn/rust-static/dist";
}
```

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

### 系统工具

| 包 | 说明 |
|----|------|
| `bat` | 增强 cat |
| `tree` | 目录树 |
| `coreutils` | GNU 核心工具 |
| `zip`, `unzip` | 压缩工具 |

## 系统级字体 (hosts/darwin.nix)

在 `hosts/darwin.nix` 中配置的系统级字体：

| 包 | 说明 |
|----|------|
| `hack-font` | Hack 字体 |
| `meslo-lgs-nf` | Meslo Nerd Font |
| `noto-fonts` | Noto 字体 |
| `noto-fonts-emoji` | Emoji 字体 |
| `nerd-fonts.roboto-mono` | Roboto Mono Nerd Font |
| `powerline` | Powerline 字体 |
