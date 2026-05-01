# Common 模块

Common 模块是跨平台共享的配置，被 macOS（通过 `modules/macos/home-manager.nix`）和独立 Home Manager（通过 `home.nix`）共同导入。

## 包含模块

| 模块 | 说明 |
|------|------|
| [Git](git.md) | Git 配置 |
| [Tmux](tmux.md) | 终端复用器配置 |
| [Zsh](zsh.md) | Zsh Shell 配置 |

## 包管理

`modules/common/packages.nix` 定义了所有用户级安装的包，包括：

- **Go 开发** — go, gopls, delve, go-tools, gotestsum
- **Rust 开发** — 通过 fenix 提供的完整工具链（含 rust-src）
- **JavaScript 开发** — nodejs_22, pnpm
- **Python** — uv, python3
- **Lua** — lua, luarocks
- **基础开发工具** — git, tmux, neovim, ripgrep, fd, fzf, lazygit, helix 等
- **系统工具** — bat, tree, coreutils, zip, unzip

## 身份数据

`inventory/default.nix` 定义了系统的基本身份信息，并通过 `specialArgs` / `extraSpecialArgs` 传给系统模块和 Home Manager 模块：

```nix
identity = {
  user = "moonshot";
  gitName = "Tetsuya";
  gitEmail = "1376490336@qq.com";
};
```
