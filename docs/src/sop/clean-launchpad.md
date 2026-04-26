# 清理 Launchpad 中已移除的 Nix 应用

## 问题描述

在 `configuration.nix` 或 home-manager 配置中注释/删除了某些应用（如 wezterm、alacritty）后，**Launchpad 中仍然能看到这些应用的图标**。

## 根本原因

Nix 的不可变 Store 设计 + 旧 generations 引用：

```
/nix/store/...-wezterm-xxx          /nix/store/...-alacritty-yyy
     ▲                                       ▲
     │          ┌──────────────┐            │
     └─────────►│ home-manager-│◄───────────┘
                │ applications │
                └──────┬───────┘
                       │
     ┌─────────────────┼─────────────────┐
     ▼                 ▼                 ▼
system-1-link    system-2-link     system-3-link (current)
 (旧 generation)  (旧 generation)   (只含 kitty)
```

旧 generations 继续引用已移除的应用，Launchpad 扫描所有可用应用时仍能发现它们。

## 解决方案

### 快速解决（推荐）

```bash
# 1. 确保配置已更新并应用
cd ~/Axiom/scripts
sh ./aarch64-darwin/build-switch

# 2. 清理旧 generations 和无用包
sudo nix-collect-garbage -d

# 3. 重启 Dock 刷新 Launchpad
killall Dock
```

### 手动清理特定 generation

```bash
# 查看所有 system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# 删除特定 generation
sudo nix-env --delete-generations 1 2 --profile /nix/var/nix/profiles/system

# 或者只保留最近 3 个
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

# 运行垃圾回收
nix-collect-garbage
```

## 如果不处理会怎样？

配置中已启用自动 GC：

```nix
nix.gc = {
  automatic = true;
  interval = { Weekday = 0; Hour = 2; Minute = 0; };  # 每周日凌晨 2 点
  options = "--delete-older-than 30d";  # 删除超过 30 天的 generations
};
```

30 天后自动 GC 会清理，但等待时间较长。

## 验证

```bash
# 确认没有残留 roots
nix-store --gc --print-roots | grep -E "wezterm|alacritty"

# 确认 store 中相关包已清理
find /nix/store -maxdepth 1 -name "*wezterm*" -o -name "*alacritty*" 2>/dev/null
```

## 相关命令速查

| 命令 | 作用 |
|------|------|
| `nix-collect-garbage -d` | 删除旧 generations 并清理无用包 |
| `nix-store --gc --print-roots` | 查看所有引用 store 包的 roots |
| `nix-store --query --roots /nix/store/...` | 查看特定包被哪些 roots 引用 |
| `nix-env --list-generations --profile /nix/var/nix/profiles/system` | 列出 system generations |
