# Homebrew

`modules/macos/homebrew.nix` 配置 Homebrew 包管理器。

## 当前配置

当前 Homebrew 配置为最小化：

```nix
homebrew = {
  enable = true;
  brews = [];    # 空列表
  casks = [];    # 空列表
};
```

所有包目前通过 Nix/Home Manager 管理，Homebrew 保留用于未来需要 GUI 应用时扩展。

## 通过 Nix 管理 Homebrew

Axiom 使用 `nix-homebrew` 输入来通过 Nix 声明式管理 Homebrew，确保 Homebrew 本身也是可复现的。
