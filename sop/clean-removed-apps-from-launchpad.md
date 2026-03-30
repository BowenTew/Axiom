# 清理 Launchpad 中已移除的 Nix 应用

## 问题描述

在 `configuration.nix` 或 home-manager 配置中注释/删除了某些应用（如 wezterm、alacritty）后，**Launchpad 中仍然能看到这些应用的图标**。

## 排查过程

### 第一步：确认配置确实已修改

检查 Nix 配置中应用是否已被注释：

```bash
grep -r "wezterm\|alacritty" /Users/tubowen/workspace/axiom --include="*.nix"
# 输出：只有注释掉的行，说明配置已更新
```

### 第二步：确认应用实际位置

这些应用实际存储在 `/nix/store`：

```bash
find /nix/store -maxdepth 3 -path "*wezterm*.app" -type d
# /nix/store/aadwcsvfywfgij101rd1q47sndp2krdm-wezterm-0-unstable-2025-07-30/Applications/WezTerm.app

find /nix/store -maxdepth 3 -path "*alacritty*.app" -type d
# /nix/store/ls93jdfyqmc67z4bmhl3w646km2by2wl-alacritty-0.15.1/Applications/Alacritty.app
```

### 第三步：追踪引用链

查看哪些 roots 还在引用这些应用：

```bash
# 查看 wezterm 被哪些 roots 引用
nix-store --query --roots /nix/store/aadwcsvfywfgij101rd1q47sndp2krdm-wezterm-0-unstable-2025-07-30

# 输出：
# /nix/var/nix/profiles/system-1-link -> /nix/store/nz37cvcx6cl0mjy55a9wya3s4b6i3x6g-darwin-system-25.11.830b3f0
# /nix/var/nix/profiles/system-2-link -> /nix/store/as6s1k9zgjbcr8cd2r5c0w2aj40mcq4q-darwin-system-25.11.830b3f0
```

发现旧 generations (system-1-link, system-2-link) 还在引用这些应用。

### 第四步：验证旧 generation 内容

```bash
# 查看旧 generation 中的 Applications
ls -la /nix/store/8v6crf58hq84j12n2w39nbikf9pxapqc-home-manager-applications/Applications/

# 输出：
# Alacritty.app -> /nix/store/ls93jdfyqmc67z4bmhl3w646km2by2wl-alacritty-0.15.1/Applications/Alacritty.app
# WezTerm.app -> /nix/store/aadwcsvfywfgij101rd1q47sndp2krdm-wezterm-0-unstable-2025-07-30/Applications/WezTerm.app
# kitty.app -> /nix/store/.../Applications/kitty.app
```

**结论**：旧 system generations 还在引用这些应用，导致 Launchpad 仍能扫描到。

## 根本原理

### Nix 的 Immutable Store 设计

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         Nix Store 结构                                   │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  /nix/store/...-wezterm-xxx          /nix/store/...-alacritty-yyy       │
│       ▲                                       ▲                         │
│       │          ┌──────────────┐            │                          │
│       └─────────►│ home-manager-│◄───────────┘                          │
│                  │ applications │                                        │
│                  └──────┬───────┘                                        │
│                         │                                                │
│     ┌───────────────────┼───────────────────┐                           │
│     ▼                   ▼                   ▼                           │
│ system-1-link      system-2-link       system-3-link (current)          │
│  (旧 generation)    (旧 generation)     (只含 kitty)                     │
│     ▲                   ▼                                              │
│     └───────────────────┘                                               │
│           都引用 wezterm + alacritty                                     │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
                    Launchpad 扫描所有可用应用
                    所以能看到已"移除"的应用
```

### 为什么注释配置≠删除应用

| 步骤 | 发生了什么 | 结果 |
|------|-----------|------|
| 1. 注释配置 | 修改 `.nix` 文件 | 配置文件改变 |
| 2. `build-switch` | Nix 构建新 generation | 创建 system-3-link |
| 3. 当前系统 | 切换到新 generation | 新配置生效 |
| 4. 旧 generations | system-1/2-link 仍然存在 | 继续引用旧包 |
| 5. 垃圾回收 | 未运行 | 旧包未被删除 |

**关键点**：Nix 的引用计数机制
- 只要还有任何 root 引用某个 store path，这个 path 就不会被删除
- Generations 就是 gcroots，阻止被引用的包被回收

### Launchpad 的扫描机制

```
Launchpad 扫描路径：
├── /Applications/
├── ~/Applications/
├── /nix/store/.../Applications/  (通过 spotlight/Nix 链接)
└── ...

即使当前 generation 不包含 wezterm，
只要 /nix/store 中还有它的 .app 且能被扫描到，
Launchpad 就会显示它。
```

## 如果不做任何处理，会被自动回收吗？

**会的，但有延迟**。

### 自动 GC 机制

你的配置中已启用自动 GC：

```nix
nix.gc = {
  automatic = true;
  interval = { Weekday = 0; Hour = 2; Minute = 0; };  # 每周日凌晨 2 点
  options = "--delete-older-than 30d";  # 删除超过 30 天的 generations
};
```

### 自动回收的时间线

```
第 0 天：注释 wezterm/alacritty，运行 build-switch
    │
    ▼
第 1-30 天：旧 generations 仍然存在，Launchpad 仍能看到
    │
    ▼
第 30+ 天：自动 GC 运行，删除超过 30 天的 generations
    │
    ▼
    如果这些旧 generations 是唯一的引用者
    wezterm/alacritty 包会被删除
    │
    ▼
Launchpad 不再显示这些应用
```

### 时间线总结

| 操作 | 何时生效 | Launchpad 显示 |
|------|---------|---------------|
| 注释配置 + build-switch | 立即 | 仍显示（旧 generation 引用） |
| 不做任何处理，等待自动 GC | 30 天后 | 仍显示（直到 GC 运行） |
| 手动运行 `nix-collect-garbage -d` | 立即 | 立即消失 |

### 为什么建议手动清理

1. **30 天太长**：不想等一个月才清理 Launchpad
2. **磁盘空间**：旧包占用空间（wezterm ~100MB，alacritty ~50MB）
3. **视觉整洁**：Launchpad 显示已不用的应用，造成困扰

## 解决方案

### 快速解决（推荐）

运行垃圾回收，删除所有不再被当前配置引用的包：

```bash
sudo nix-collect-garbage -d
```

参数说明：
- `-d` (`--delete-old`)：删除所有旧的 generations，只保留当前

### 手动清理（可选）

如果你只想删除特定 generation：

```bash
# 查看所有 system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# 删除特定 generation
sudo nix-env --delete-generations 1 2 --profile /nix/var/nix/profiles/system

# 或者只保留最近 3 个 generations
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

# 最后运行垃圾回收
nix-collect-garbage
```

### 清理 home-manager generations（如果适用）

```bash
# 查看 home-manager generations
home-manager generations

# 清理旧的 home-manager generations
nix-collect-garbage -d
```

## 清理后验证

1. **检查 Launchpad**：重启 Dock 刷新 Launchpad
   ```bash
   killall Dock
   ```

2. **验证应用已被移除**：
   ```bash
   # 确认没有 wezterm/alacritty 的 roots
   nix-store --gc --print-roots | grep -E "wezterm|alacritty"
   
   # 确认 store 中相关包已被清理
   find /nix/store -maxdepth 1 -name "*wezterm*" -o -name "*alacritty*" 2>/dev/null
   ```

## 完整操作流程

```bash
# 1. 确保配置已更新并应用
cd ~/Axiom/scripts
sh ./aarch64-darwin/build-switch

# 2. 清理旧 generations 和无用包
sudo nix-collect-garbage -d

# 3. 重启 Dock 刷新 Launchpad
killall Dock
```

## 注意事项

1. **Generation 的作用**：
   - Generations 允许你回滚到之前的系统状态
   - 清理后无法回滚到被删除的 generation

2. **定期清理**：
   - Nix 配置中已启用自动 GC（`nix.gc.automatic = true`）
   - 但自动 GC 默认只删除超过 30 天的包，不会立即清理

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
| `find /nix/store -name "*wezterm*"` | 查找 store 中的 wezterm 包 |
