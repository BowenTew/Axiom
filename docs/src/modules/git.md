# Git

`modules/common/git.nix` 定义了 Git 版本控制工具的配置。

## 基础配置

| 选项 | 值 | 说明 |
|------|-----|------|
| `userName` | `axiomIdentity.gitName` | 从身份模块读取 |
| `userEmail` | `axiomIdentity.gitEmail` | 从身份模块读取 |
| `init.defaultBranch` | `main` | 默认分支名 |
| `core.editor` | `vim` | 默认编辑器 |
| `core.autocrlf` | `input` | 行尾符处理 |
| `pull.rebase` | `true` | pull 时使用 rebase |
| `rebase.autoStash` | `true` | rebase 前自动 stash |

## 启用功能

- **Git LFS** — 大文件支持
- **全局忽略** — `*.swp` 文件
