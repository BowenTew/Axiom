# Flake 设计

`flake.nix` 是 Axiom 的核心入口，定义了所有输入、输出和系统配置。

## 输入 (Inputs)

| 输入 | 用途 |
|------|------|
| `nixpkgs` | Nix 包集合 (nixos-unstable) |
| `home-manager` | 用户环境管理 |
| `darwin` | nix-darwin (macOS 系统配置) |
| `nix-homebrew` | Nix 管理 Homebrew |
| `homebrew-bundle/core/cask` | Homebrew 相关 |
| `disko` | 声明式磁盘分区 (NixOS) |
| `fenix` | Rust 工具链 |

## 输出 (Outputs)

### DevShells

为所有支持的平台提供统一的开发环境：

```nix
devShells = forAllSystems devShell;
```

支持的平台：
- `x86_64-linux`
- `aarch64-linux`
- `aarch64-darwin`
- `x86_64-darwin`

### Apps

每个平台都有一组便捷的构建命令：

**Linux Apps:**
- `apply`
- `build-switch`
- `copy-keys`
- `create-keys`
- `check-keys`
- `install`

**Darwin Apps:**
- `apply`
- `build`
- `build-switch`
- `copy-keys`
- `create-keys`
- `check-keys`
- `rollback`

### Darwin Configurations

macOS 系统配置由 `hosts/darwin.nix` 导入。
