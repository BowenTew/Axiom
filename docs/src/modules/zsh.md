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
$HOME/.pnpm-packages/bin
$HOME/.npm-packages/bin
$HOME/.local/share/bin
/opt/homebrew/bin        # macOS Homebrew
$HOME/.local/bin

# NPM
NPM_CONFIG_PREFIX=$HOME/.npm-packages
```

## 别名

| 别名 | 命令 |
|------|------|
| `diff` | `difft` (语法感知的 diff) |
| `ls` | `ls --color=auto` |

## 函数

| 函数 | 说明 |
|------|------|
| `shell <pkg>` | 快速进入 nix-shell，如 `shell go` |

## Nix 集成

自动检测并加载 Nix daemon 环境：
- `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh`
- `/nix/var/nix/profiles/default/etc/profile.d/nix.sh`

## 历史记录

排除常用命令：`pwd`, `ls`, `cd`
