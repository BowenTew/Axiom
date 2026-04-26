# Home Manager

`modules/macos/home-manager.nix` 配置 Home Manager 用户环境。

## 配置

| 选项 | 值 | 说明 |
|------|-----|------|
| `useGlobalPkgs` | `true` | 使用全局 nixpkgs |
| `backupFileExtension` | `"backup"` | 备份后缀 |
| `stateVersion` | `"23.11"` | Home Manager 版本 |

## 导入的 Common 模块

Home Manager 用户配置导入了所有 common 模块：

```nix
imports = [
  ../common/git.nix
  ../common/zsh.nix
  ../common/tmux.nix
  ../common/vim
];
```

## 其他设置

- `enableNixpkgsReleaseCheck = false` — 禁用版本检查
- `manual.manpages.enable = false` — 禁用 man page
