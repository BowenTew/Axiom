# Zsh

`modules/common/zsh.nix` 配置了 Zsh Shell 环境。

## Oh My Zsh

| 配置 | 值 |
|------|-----|
| 主题 | `robbyrussell` |
| 插件 | `git`, `web-search` |

## 环境变量

```bash
# PATH 追加
/opt/homebrew/bin        # macOS Homebrew
$HOME/.local/bin
$HOME/.pnpm-packages/bin
$HOME/.npm-packages/bin
$HOME/.local/share/bin
$HOME/.cargo/bin          # Rust/Cargo

# NPM
NPM_CONFIG_PREFIX=$HOME/.npm-packages
```

## 别名

| 别名 | 命令 |
|------|------|
| `diff` | `difft` (语法感知的 diff) |
| `ls` | `ls -G` |
| `ll` | `ls -la` |
| `la` | `ls -a` |

## 函数

| 函数 | 说明 |
|------|------|
| `shell <pkg>` | 快速进入 nix-shell，如 `shell go` |

## Nix 集成

自动检测并加载 Nix daemon 环境：
- `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh`
- `/nix/var/nix/profiles/default/etc/profile.d/nix.sh`

## 本地覆盖

支持本地自定义配置：
- `$HOME/.zshenv.local` — 环境变量覆盖
- `$HOME/.zshrc.local` — 交互式配置覆盖

## 历史记录

- 大小：50000 条
- 排除常用命令：`pwd`, `ls`, `cd`
- 去重：启用
