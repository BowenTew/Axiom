# macOS 模块

`modules/macos/` 目录包含 macOS 专用的配置模块。

## 模块结构

```nix
# modules/macos/default.nix
imports = [
  ../common/identity.nix    # 身份信息
  ./home-manager.nix        # Home Manager 配置
  ./homebrew.nix            # Homebrew 包管理
  ./packages.nix            # 系统/用户包
];
```

## 子模块

- [Home Manager](home-manager.md)
- [Homebrew](homebrew.md)
- [Packages](packages.md)
