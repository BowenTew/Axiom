# Nix Templates 使用指南

## 什么是 Template

Nix Template 是一种**项目脚手架（scaffolding）**机制，用于快速生成带有 Nix 开发环境配置的新项目。

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   axiom 仓库     │     │  nix flake init │     │   新项目目录      │
│   (远程存储)      │     │                 │     │                 │
│  templates/     │────→│  复制模板文件     │────→│  flake.nix      │
│  └── go/        │     │  到本地新项目     │     │  (独立自包含)     │
│      └── flake.nix│   │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

核心特点：
- 生成后的项目是**独立的**，不依赖 axiom 仓库
- 新项目有自己的 `flake.lock`，版本自主可控
- 可以提交到新项目的 git，团队共享

---

## 可用模板列表

axiom 提供以下项目模板：

| 模板名 | 说明 | 包含工具 |
|--------|------|----------|
| `go` | Go 项目 | go, gopls, delve, go-tools, gotestsum |
| `node20` | Node.js 20 项目 | nodejs_20, pnpm, yarn, typescript |
| `node22` | Node.js 22 项目 | nodejs_22, pnpm, yarn, typescript |
| `deno` | Deno 项目 | deno |
| `java8` | Java 8 项目 | jdk8, maven, gradle |
| `java11` | Java 11 项目 | jdk11, maven, gradle |
| `java17` | Java 17 项目 | jdk17, maven, gradle |
| `rust-wasm` | Rust + WebAssembly | rust, wasm-pack, binaryen, lld |

---

## 本地使用（开发测试）

### 1. 创建新项目目录

```bash
mkdir ~/projects/my-api
cd ~/projects/my-api
```

### 2. 从模板初始化

```bash
# 使用 Go 模板
nix flake init -t ~/github/tubowen/axiom#go

# 或使用 Node.js 22 模板
nix flake init -t ~/github/tubowen/axiom#node22

# 或使用 Rust WASM 模板
nix flake init -t ~/github/tubowen/axiom#rust-wasm
```

> 注意：路径 `~/github/tubowen/axiom` 根据你本地 axiom 仓库实际位置调整。

### 3. 进入开发环境

```bash
nix develop
```

此时你已处于隔离的开发环境中，所有工具可用。

### 4. 开始项目开发

```bash
# Go 项目示例
go mod init my-api
go mod tidy

# Node.js 项目示例
npm init
npm install

# Rust 项目示例
cargo init
cargo build
```

---

## 远程使用（git push 后）

axiom 推送到 GitHub 后，任何人都可以使用：

```bash
nix flake init -t github:moonshot/axiom#go
```

团队成员无需安装任何全局依赖，只需 Nix 即可进入一致的开发环境。

---

## 模板生成后的项目结构

以 `go` 模板为例，执行 `nix flake init` 后：

```
my-api/
├── flake.nix          # 从模板复制的项目级 flake
├── flake.lock         # 自动生成的版本锁定文件
└── ...                # 你的项目代码
```

`flake.nix` 内容示例：

```nix
{
  description = "Go project template";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              go
              gopls
              delve
              go-tools
              gotestsum
            ];
          };
        });
    };
}
```

这是一个**完全独立**的 project 级别 flake，与 axiom 再无耦合。

---

## 与 devShells 的区别

| 特性 | Templates（当前） | devShells（旧方式） |
|------|-------------------|---------------------|
| flake 归属 | project 级别 | machine 级别（axiom） |
| 新项目是否依赖 axiom | ❌ 不依赖 | ✅ 依赖 |
| 版本锁定 | 项目自有 `flake.lock` | 跟随 axiom 的 `flake.lock` |
| 使用方式 | `nix flake init -t` 后 `nix develop` | `cd axiom && nix develop .#go` |
| 团队协作 | ✅ 项目自带环境配置 | ❌ 需要团队成员也配置 axiom |
| 适用场景 | 项目脚手架、团队共享 | 个人快速切换环境 |

---

## 进阶：自定义模板

如需添加新模板：

1. 在 `axiom/templates/` 下创建新目录
2. 编写 `flake.nix`（project 级别）
3. 在 `axiom/flake.nix` 的 `templates` 输出中注册

示例：

```nix
# axiom/flake.nix
{
  outputs = { ... }: {
    templates = {
      my-template = {
        path = ./templates/my-template;
        description = "My custom project template";
      };
    };
  };
}
```

---

## 常见问题

### Q: 模板初始化后想更新依赖版本怎么办？

```bash
# 更新 flake.lock 到最新
nix flake update
```

### Q: 如何查看模板内容而不初始化？

```bash
# 查看模板目录结构
ls ~/github/tubowen/axiom/templates/go/

# 查看模板 flake.nix
cat ~/github/tubowen/axiom/templates/go/flake.nix
```

### Q: 可以修改生成后的 flake.nix 吗？

完全可以。`nix flake init` 只是复制模板，生成后的文件完全由你控制。

### Q: 团队成员没有 Nix 怎么办？

生成的 `flake.nix` 是标准 Nix 配置，团队成员只需：
1. 安装 Nix（https://nixos.org/download）
2. 进入项目目录执行 `nix develop`

---

## 相关命令速查

| 命令 | 说明 |
|------|------|
| `nix flake init -t <source>#<name>` | 从模板初始化项目 |
| `nix develop` | 进入当前项目的开发环境 |
| `nix flake update` | 更新 flake.lock 依赖 |
| `nix flake show` | 查看当前 flake 的输出 |
| `nix flake metadata` | 查看 flake 元信息 |
