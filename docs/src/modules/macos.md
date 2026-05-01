# macOS 模块

`modules/macos/` 目录包含 macOS 专用的配置模块。

## 模块结构

```nix
# modules/macos/default.nix
{ pkgs, ... }:
{
  imports = [
    ./home-manager.nix        # Home Manager 配置
    ./homebrew.nix            # Homebrew 包管理
  ];
  environment.systemPackages = with pkgs; [ zsh ];
}
```

注意：`modules/macos/packages.nix` 存在但**未被 `default.nix` 导入**。其中的包定义已通过其他方式整合到配置中。

## 子模块

- [Home Manager](home-manager.md)
- [Homebrew](homebrew.md)
