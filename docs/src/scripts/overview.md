# 脚本概览

`scripts/` 目录包含各架构的构建和部署脚本。

## 目录结构

```
scripts/
├── aarch64-darwin/     # Apple Silicon Mac
│   ├── apply
│   ├── build
│   ├── build-switch
│   └── rollback
├── x86_64-darwin/      # Intel Mac
│   ├── apply
│   ├── build
│   ├── build-switch
│   ├── check-keys
│   ├── copy-keys
│   ├── create-keys
│   └── rollback
└── x86_64-linux/       # x86_64 Linux
    ├── apply
    └── build-switch
```

> 注意：`aarch64-linux` 是 `x86_64-linux` 的符号链接。

## 脚本说明

### build-switch

构建并切换到新配置（最常用）：

```sh
cd scripts
sh ./aarch64-darwin/build-switch
```

流程：
1. `nix build .#darwinConfigurations.aarch64-darwin.system`
2. `sudo darwin-rebuild switch --flake .#aarch64-darwin`
3. 清理 `result` 链接

### build

仅构建，不切换：

```sh
sh ./aarch64-darwin/build
```

### apply

交互式配置应用脚本，支持：
- 自动检测用户名
- 从 git config 读取身份信息
- 密钥生成和管理
- 系统类型自动识别

### rollback

回滚到上一系统 generation：

```sh
sh ./aarch64-darwin/rollback
```

### create-keys / copy-keys / check-keys

密钥管理脚本（x86_64-darwin 特有）：

| 脚本 | 功能 |
|------|------|
| `create-keys` | 生成新的 SSH/年龄密钥 |
| `copy-keys` | 复制密钥到目标位置 |
| `check-keys` | 检查密钥状态 |
