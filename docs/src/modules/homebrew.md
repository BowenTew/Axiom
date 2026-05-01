# Homebrew

`modules/macos/homebrew.nix` 配置 Homebrew 包管理器。

## 当前配置

```nix
homebrew = {
  enable = true;
  brews = [];    # 空列表
  casks = [
    "kitty"
    "ghostty"
  ];
};
```

大部分包通过 Nix/Home Manager 管理，Homebrew 保留用于 GUI 应用。

## 通过 Nix 管理 Homebrew

使用 `nix-homebrew` 输入来通过 Nix 声明式管理 Homebrew，确保 Homebrew 本身也是可复现的。

在 `hosts/darwin.nix` 中配置：

```nix
nix-homebrew = {
  user = axiomIdentity.user;
  enable = true;
  mutableTaps = false;
  autoMigrate = true;
  taps = {
    "homebrew/homebrew-core" = homebrew-core;
    "homebrew/homebrew-cask" = homebrew-cask;
    "homebrew/homebrew-bundle" = homebrew-bundle;
  };
};
```
