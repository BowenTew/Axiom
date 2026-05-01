# Templates 概览

Bootstrap 提供了一系列 `nix flake init` 模板，用于快速初始化各语言的开发环境。

## 什么是 Template

Nix Template 是一种**项目脚手架（scaffolding）**机制，用于快速生成带有 Nix 开发环境配置的新项目。

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   bootstrap 仓库     │     │  nix flake init │     │   新项目目录      │
│   (远程存储)      │     │                 │     │                 │
│  templates/     │────→│  复制模板文件     │────→│  flake.nix      │
│  └── deno/      │     │  到本地新项目     │     │  (独立自包含)     │
│      └── flake.nix│   │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

核心特点：
- 生成后的项目是**独立的**，不依赖 bootstrap 仓库
- 新项目有自己的 `flake.lock`，版本自主可控
- 可以提交到新项目的 git，团队共享

## 使用方式

### 远程使用

```sh
nix flake init -t github:BeauvnTu/Bootstrap#<template-name>
```

### 本地使用（开发测试）

```sh
mkdir ~/projects/my-app && cd ~/projects/my-app
nix flake init -t ~/github/self/bootstrap#<template-name>
nix develop
```

> 路径根据本地 bootstrap 仓库实际位置调整。

## 可用模板

| 模板 | 说明 | 使用 |
|------|------|------|
| [Deno](deno.md) | Deno 运行时 | `nix flake init -t github:BeauvnTu/Bootstrap#deno` |
| [Java](java.md) | JDK 17 + Maven + Gradle | `nix flake init -t github:BeauvnTu/Bootstrap#java` |
| [Rust + WASM](rust-wasm.md) | Rust + WebAssembly | `nix flake init -t github:BeauvnTu/Bootstrap#rust-wasm` |

## 通用特性

所有模板都支持以下平台：
- `aarch64-darwin` (Apple Silicon)
- `x86_64-darwin` (Intel Mac)
- `aarch64-linux`
- `x86_64-linux`

## 模板生成后的项目结构

以 Deno 模板为例，执行 `nix flake init` 后：

```
my-app/
├── flake.nix          # 从模板复制的项目级 flake
├── flake.lock         # 自动生成的版本锁定文件
└── ...                # 你的项目代码
```

生成的 `flake.nix` 是**完全独立**的 project 级别 flake，与 bootstrap 再无耦合。

### flake.nix 示例

以 Deno 模板为例，生成的 `flake.nix` 内容类似：

```nix
{
  description = "Deno project template";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin" "x86_64-darwin"
        "aarch64-linux" "x86_64-linux"
      ];
    in
    {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ deno ];
          };
        });
    };
}
```

初始化完成后即可开始开发：

```bash
# 进入开发环境
nix develop

# 各语言示例
go mod init my-api     # Go
npm init               # Node.js
cargo init             # Rust
```

## 定义位置

模板在 `flake.nix` 中通过 `templates/default.nix` 引入：

```nix
templates = import ./templates;
```

`templates/default.nix` 内容示例：

```nix
{
  templates = {
    deno = {
      path = ./deno;
      description = "Deno project";
    };
    # ...
  };
}
```

## 自定义模板

如需添加新模板：

1. 在 `templates/` 下创建新目录（如 `templates/my-template/`）
2. 编写 `flake.nix`（project 级别）
3. 在 `templates/default.nix` 中注册

```nix
# templates/default.nix
{
  templates = {
    # ... 已有模板
    my-template = {
      path = ./my-template;
      description = "My custom project template";
    };
  };
}
```

## 常见问题

### 模板初始化后想更新依赖版本？

```bash
nix flake update
```

### 如何查看模板内容而不初始化？

```bash
ls ~/github/self/bootstrap/templates/deno/
cat ~/github/self/bootstrap/templates/deno/flake.nix
```

### 可以修改生成后的 flake.nix 吗？

完全可以。`nix flake init` 只是复制模板，生成后的文件完全由你控制。

### 团队成员没有 Nix 怎么办？

只需：
1. 安装 Nix（<https://nixos.org/download>）
2. 进入项目目录执行 `nix develop`

## 相关命令速查

| 命令 | 说明 |
|------|------|
| `nix flake init -t <source>#<name>` | 从模板初始化项目 |
| `nix develop` | 进入当前项目的开发环境 |
| `nix flake update` | 更新 flake.lock 依赖 |
| `nix flake show` | 查看当前 flake 的输出 |
| `nix flake metadata` | 查看 flake 元信息 |
