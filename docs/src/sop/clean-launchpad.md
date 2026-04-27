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

### Launchpad 扫描机制

```
Launchpad 扫描路径：
├── /Applications/
├── ~/Applications/
├── /nix/store/.../Applications/  (通过 Spotlight/Nix 链接)
└── ...
```

即使当前 generation 不包含 wezterm，只要 `/nix/store` 中还有它的 `.app` 且能被扫描到，Launchpad 就会显示它。

### 为什么注释配置 ≠ 删除应用

| 步骤 | 发生了什么 | 结果 |
|------|-----------|------|
| 1. 注释配置 | 修改 `.nix` 文件 | 配置文件改变 |
| 2. `build-switch` | Nix 构建新 generation | 创建 system-3-link |
| 3. 当前系统 | 切换到新 generation | 新配置生效 |
| 4. 旧 generations | system-1/2-link 仍然存在 | 继续引用旧包 |
| 5. 垃圾回收 | 未运行 | 旧包未被删除 |

**关键点**：只要还有任何 root 引用某个 store path，这个 path 就不会被删除。Generations 就是 gcroots，阻止被引用的包被回收。

## 排查思路

### 第一步：确认配置确实已修改

```bash
grep -r "wezterm\|alacritty" ~/github/tubowen/axiom --include="*.nix"
# 输出：只有注释掉的行，说明配置已更新
```

### 第二步：确认应用实际位置

```bash
find /nix/store -maxdepth 3 -path "*wezterm*.app" -type d
find /nix/store -maxdepth 3 -path "*alacritty*.app" -type d
```

### 第三步：追踪引用链

```bash
# 查看应用被哪些 roots 引用
nix-store --query --roots /nix/store/<hash>-wezterm-xxx
```

如果输出指向旧 generations（如 `system-1-link`），说明是旧 generation 阻止了回收。

### 第四步：验证旧 generation 内容

```bash
ls -la /nix/store/<hash>-home-manager-applications/Applications/
```

## 解决方案

### 快速解决（推荐）

```bash
# 1. 确保配置已更新并应用
cd ~/github/tubowen/axiom
sh scripts/aarch64-darwin/build-switch

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

### 清理 home-manager generations

```bash
# 查看 home-manager generations
home-manager generations

# 清理旧的 home-manager generations
nix-collect-garbage -d
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

| 操作 | 何时生效 | Launchpad 显示 |
|------|---------|---------------|
| 注释配置 + build-switch | 立即 | 仍显示（旧 generation 引用） |
| 不做任何处理，等待自动 GC | 30 天后 | 仍显示（直到 GC 运行） |
| 手动运行 `nix-collect-garbage -d` | 立即 | 立即消失 |

### 为什么建议手动清理

1. **30 天太长**：不想等一个月才清理 Launchpad
2. **磁盘空间**：旧包占用空间（wezterm ~100MB，alacritty ~50MB）
3. **视觉整洁**：Launchpad 显示已不用的应用，造成困扰

## 验证

```bash
# 确认没有残留 roots
nix-store --gc --print-roots | grep -E "wezterm|alacritty"

# 确认 store 中相关包已清理
find /nix/store -maxdepth 1 -name "*wezterm*" -o -name "*alacritty*" 2>/dev/null
```

## 注意事项

1. **Generation 的作用**：Generations 允许回滚到之前的系统状态，清理后无法回滚到被删除的 generation
2. **定期清理**：自动 GC 默认只删除超过 30 天的包，不会立即清理
3. **如果 Launchpad 仍显示**：
   - 检查是否通过 Homebrew 单独安装：`brew list | grep -i wezterm`
   - 检查 `/Applications` 或 `~/Applications` 目录
   - 手动删除残留：`rm -rf ~/Applications/Home\ Manager\ Apps/xxx.app`

## 相关命令速查

| 命令 | 作用 |
|------|------|
| `nix-collect-garbage -d` | 删除旧 generations 并清理无用包 |
| `nix-store --gc --print-roots` | 查看所有引用 store 包的 roots |
| `nix-store --query --roots /nix/store/...` | 查看特定包被哪些 roots 引用 |
| `nix-env --list-generations --profile /nix/var/nix/profiles/system` | 列出 system generations |
| `home-manager generations` | 列出 home-manager generations |
| `find /nix/store -maxdepth 1 -name "*wezterm*"` | 查找 store 中的残留包 |
