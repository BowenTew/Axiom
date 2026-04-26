# Common 模块

Common 模块是跨平台共享的配置，被 macOS 和 NixOS 共同导入。

## 包含模块

| 模块 | 说明 |
|------|------|
| [Git](git.md) | Git 配置 |
| [Tmux](tmux.md) | 终端复用器配置 |
| [Vim](vim.md) | Vim 编辑器配置 |
| [Zsh](zsh.md) | Zsh Shell 配置 |

## 身份模块

`identity.nix` 定义了系统的基本身份信息：

```nix
axiom.identity = {
  user = "moonshot";           # 主用户名
  gitName = "Tetsuya";         # Git 用户名
  gitEmail = "1376490336@qq.com";  # Git 邮箱
};
```

这些选项可以被各主机配置覆盖。
