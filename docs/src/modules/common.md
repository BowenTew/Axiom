# Common 模块

Common 模块是跨平台共享的配置，被 macOS 和 NixOS 共同导入。

## 包含模块

| 模块 | 说明 |
|------|------|
| [Git](git.md) | Git 配置 |
| [Tmux](tmux.md) | 终端复用器配置 |
| [Vim](vim.md) | Vim 编辑器配置 |
| [Zsh](zsh.md) | Zsh Shell 配置 |

## 身份数据

`inventory/default.nix` 定义了系统的基本身份信息，并通过 `specialArgs` / `extraSpecialArgs` 传给系统模块和 Home Manager 模块：

```nix
identity = {
  user = "moonshot";
  gitName = "Tetsuya";
  gitEmail = "1376490336@qq.com";
};
```
