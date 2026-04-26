# Tmux

`modules/common/tmux.nix` 配置了功能丰富的 Tmux 终端复用器。

## 前缀键

| 键位 | 功能 |
|------|------|
| `C-x` | 前缀键（替代默认的 `C-b`） |

## 分屏操作

| 快捷键 | 功能 |
|--------|------|
| `prefix + x` | 水平分屏 |
| `prefix + v` | 垂直分屏 |
| `Alt + h/j/k/l` | 在 pane 间移动 |
| `Ctrl + h/j/k/l` | 智能切换（兼容 Vim） |

## 插件

| 插件 | 功能 |
|------|------|
| `vim-tmux-navigator` | 与 Vim 无缝导航 |
| `sensible` | 合理默认配置 |
| `yank` | 系统剪贴板集成 |
| `prefix-highlight` | 前缀键状态高亮 |
| `power-theme` | 金色主题 `gold` |
| `resurrect` | 会话保存/恢复 |
| `continuum` | 自动保存（每 5 分钟） |

## 其他配置

- 鼠标支持：启用
- 历史限制：50000 行
- 焦点事件：启用（减少 Vim 延迟）
- 转义时间：10ms
