# Flake 设计

`flake.nix` 是仓库的核心入口，定义了所有输入、输出和系统配置。

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

macOS 系统配置由 `hosts/darwin.nix` 导入，支持 `aarch64-darwin` 和 `x86_64-darwin`。

### Home Configurations

独立的 Home Manager 配置，不依赖 nix-darwin：

```nix
homeConfigurations = {
  ${inventory.identity.user} = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    extraSpecialArgs = {
      inherit inputs;
      axiomIdentity = inventory.identity;
    };
    modules = [ ./home.nix ];
  };
};
```

使用方式：
```sh
home-manager switch --flake .#moonshot
```

### DevShells

为所有支持的平台提供统一的文档开发环境：

```nix
devShells = forAllSystems (system: {
  default = docsShell system;
});
```

支持的平台：
- `x86_64-linux`
- `aarch64-linux`
- `aarch64-darwin`
- `x86_64-darwin`

当前唯一的 devShell 是 `default`，包含 `mdbook` 用于构建文档。

### Templates

项目模板通过 `templates/default.nix` 引入：

```nix
templates = import ./templates;
```

可用模板：
- `deno` — Deno 运行时
- `java` — JDK 17 + Maven + Gradle
- `rust-wasm` — Rust + WebAssembly

使用方式：
```sh
nix flake init -t github:BeauvnTu/Bootstrap#<template-name>
```
