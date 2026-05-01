# Home Manager

`modules/macos/home-manager.nix` 配置 Home Manager 用户环境。

## 配置

| 选项 | 值 | 说明 |
|------|-----|------|
| `useGlobalPkgs` | `true` | 使用全局 nixpkgs |
| `backupFileExtension` | `"backup"` | 备份后缀 |

## 导入的 Common 模块

Home Manager 用户配置导入了所有 common 模块：

```nix
users.${identity.user} = { ... }: {
  imports = [
    ../common
  ];
};
```

`../common` 包含：
- `git.nix` — Git 配置
- `zsh.nix` — Zsh 配置
- `tmux.nix` — Tmux 配置

## 参数传递

Home Manager 通过 `extraSpecialArgs` 接收外部参数：

```nix
home-manager.extraSpecialArgs = {
  inherit axiomIdentity inputs;
};
```

- `axiomIdentity` — 用户身份信息（来自 `inventory/default.nix`）
- `inputs` — Flake 的所有输入（用于 `fenix` Rust 工具链等）

## 其他设置

- `enableNixpkgsReleaseCheck = false` — 禁用版本检查（在 `modules/common/default.nix`）
- `stateVersion = "23.11"` — Home Manager 版本（在 `modules/common/default.nix`）
- `manual.manpages.enable = false` — 禁用 man page（在 `modules/common/default.nix`）
