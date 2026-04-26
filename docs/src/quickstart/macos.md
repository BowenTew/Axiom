# macOS (nix-darwin) 配置

## 1. 克隆仓库

```zsh
git clone git@github.com:BeauvnTu/Axiom.git
cd Axiom
```

## 2. 进入脚本目录

```zsh
cd scripts
```

## 3. 运行构建

根据你的架构选择对应的脚本：

```zsh
# Apple Silicon (M1/M2/M3)
sh ./aarch64-darwin/build-switch

# Intel Mac
sh ./x86_64-darwin/build-switch
```

## 4. 首次运行后的操作

构建完成后，系统会自动配置：
- Homebrew 包
- macOS 系统设置
- Home Manager 用户配置

## 可用命令

| 命令 | 说明 |
|------|------|
| `build` | 仅构建，不切换 |
| `build-switch` | 构建并切换到新配置 |
| `apply` | 应用配置 |
| `rollback` | 回滚到上一版本 |
| `create-keys` | 创建密钥 |
| `copy-keys` | 复制密钥 |
| `check-keys` | 检查密钥 |

## 故障排查

- [清理 Launchpad 残留图标 →](../sop/clean-launchpad.md)
- [Neovim Lua 缓存问题 →](../sop/nvim-cache.md)
