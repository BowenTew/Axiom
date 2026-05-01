# 目录结构

```
.
├── assets/                  # 静态资源（图标、图片）
│   ├── linux.svg
│   ├── macos.svg
│   └── nix-icon.svg
├── docs/                    # mdBook 文档站
│   ├── book.toml
│   ├── book/                # 构建输出（GitHub Pages）
│   └── src/                 # Markdown 源文件
├── hosts/                   # 主机配置
│   ├── darwin.nix           # macOS 系统配置入口
│   └── nixos.nix            # NixOS 配置模板（开发中）
├── inventory/               # 身份信息
│   └── default.nix
├── modules/                 # 模块化配置
│   ├── common/              # 跨平台通用模块（Home Manager）
│   │   ├── default.nix
│   │   ├── git.nix
│   │   ├── packages.nix
│   │   ├── tmux.nix
│   │   └── zsh.nix
│   └── macos/               # macOS 专用模块
│       ├── default.nix
│       ├── home-manager.nix
│       ├── homebrew.nix
│       └── packages.nix
├── overlays/                # Nixpkgs overlay
│   └── README.md
├── scripts/                 # 构建/部署脚本
│   ├── aarch64-darwin/
│   ├── x86_64-darwin/
│   ├── x86_64-linux/
│   ├── apply.sh
│   └── setup.sh
├── templates/               # nix flake init 项目模板
│   ├── default.nix
│   ├── deno/
│   ├── java/
│   └── rust-wasm/
├── flake.lock               # Flake 依赖锁定
├── flake.nix                # Flake 入口
├── home.nix                 # 独立 Home Manager 配置入口
└── README.md
```
