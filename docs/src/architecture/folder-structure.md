# 目录结构

```
.
├── apps/                    # 应用脚本
│   └── software.md
├── assets/                  # 静态资源（图标、图片）
│   ├── linux.svg
│   ├── macos.svg
│   └── nix-icon.svg
├── templates/               # 项目模板
│   ├── default.nix
│   ├── deno/
│   ├── java/
│   └── rust-wasm/
├── docs/                    # 本文档站
│   ├── book.toml
│   └── src/
├── flake.lock               # Flake 依赖锁定
├── flake.nix                # Flake 入口
├── hosts/                   # 主机配置
│   ├── darwin.nix
│   └── nixos.nix
├── modules/                 # 模块化配置
│   ├── common/              # 跨平台通用模块
│   └── macos/               # macOS 专用模块
├── overlays/                # Nixpkgs overlay
│   └── README.md
├── scripts/                 # 构建/部署脚本
│   ├── aarch64-darwin/
│   ├── aarch64-linux/
│   ├── x86_64-darwin/
│   └── x86_64-linux/
└── sop/                     # 运维手册
    ├── clean-removed-apps-from-launchpad.md
    └── nvim-lua-cache-issues.md
```
