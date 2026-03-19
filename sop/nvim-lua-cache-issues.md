# Neovim Lua 模块缓存问题处理 SOP

## 问题表现

启动 Neovim 时，LSP 配置加载失败，报错如下：

```
Failed to load `plugins.lsp.lspconfig`

/Users/moonshot/.config/nvim/lua/config/lsp/init.lua:18: module 'config.lsp.vuels' not found:
	no field package.preload['config.lsp.vuels']
	cache_loader: module 'config.lsp.vuels' not found
	cache_loader_lib: module 'config.lsp.vuels' not found
	no file '/nix/store/.../share/lua/5.1/config/lsp/vuels.lua'
	...
```

**关键特征：**
- 错误指向的模块名（`vuels`）与实际配置文件中的内容（`vtsls`）不符
- 错误发生在 Lua 模块加载阶段
- 使用了 Nix + Home Manager 管理 Neovim 配置

---

## 问题原因

### 根本原因
Neovim 的 Lua 字节码缓存（`.luac` 文件）未正确刷新，导致加载了旧的编译结果。

### 具体原因分析

1. **LuaJIT/Lua 5.1 缓存机制**
   - Neovim 使用 LuaJIT 或 Lua 5.1 运行 Lua 代码
   - 为加速启动，会将 Lua 文件编译为字节码缓存到 `~/.cache/nvim/luac/`
   - 缓存文件名经过 URL 编码，对应原始文件路径

2. **配置变更与缓存不一致**
   - 配置从 `vuels` 修改为 `vtsls`
   - 但缓存中仍保留着对 `vuels` 的引用
   - Neovim 优先使用缓存，导致加载了过期的字节码

3. **Nix 符号链接的复杂性**
   - 配置文件通过符号链接指向 Nix Store
   - 当 Nix Store 路径变化时，缓存可能指向旧位置
   - 文件内容变化但路径不变时，缓存检测机制可能失效

---

## 分析思路

### 第一步：验证配置文件内容
```bash
# 检查实际配置文件内容
cat ~/.config/nvim/lua/config/lsp/init.lua
```

**预期结果：** 文件内容正确，第 18 行应为 `vtsls` 而非 `vuels`

### 第二步：检查 Nix Store 中的文件
```bash
# 查看 Nix Store 中的实际配置
cat /nix/store/...-hm_conf/lua/config/lsp/init.lua
```

**预期结果：** Nix Store 中的文件也是正确的

### 第三步：定位缓存问题
```bash
# 查看 Lua 字节码缓存目录
ls ~/.cache/nvim/luac/
```

**关键发现：**
- 缓存目录存在大量 `.luac` 文件
- 文件名经过 URL 编码（如 `%2fUsers%2fmoonshot%2f...`）
- 即使源文件已更新，缓存可能未同步刷新

### 第四步：确认缓存机制
- Neovim 使用 `cache_loader` 加载模块（见错误信息）
- 错误信息中 `cache_loader: module 'config.lsp.vuels' not found` 表明缓存系统参与了加载过程

---

## 处理流程

### 快速解决（推荐首选）

```bash
# 1. 清除 Lua 字节码缓存
rm -rf ~/.cache/nvim/luac

# 2. 重启 Neovim
nvim
```

### 进阶解决（快速方案无效时）

```bash
# 1. 清除所有 Neovim 缓存
rm -rf ~/.cache/nvim/

# 2. 清除 lazy.nvim 插件缓存（会重新下载插件）
rm -rf ~/.local/share/nvim/lazy/

# 3. 重启 Neovim，等待插件重新安装
nvim
```

### 彻底清除（最后手段）

```bash
# 清除所有 Neovim 相关数据（相当于完全重置）
rm -rf ~/.cache/nvim/
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/

# 重启 Neovim
nvim
```

---

## 预防措施

### 方案一：Home Manager 激活脚本（推荐）

在 Nix 配置中添加自动清除缓存的激活脚本：

```nix
{ config, lib, ... }:

{
  # ... 其他配置 ...

  # 切换配置时清除 Neovim Lua 缓存
  home.activation.clearNvimCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${config.home.homeDirectory}/.cache/nvim/luac"
  '';
}
```

### 方案二：手动添加到 shell 别名

```bash
# ~/.zshrc 或 ~/.bashrc
alias nvim-clean='rm -rf ~/.cache/nvim/luac && nvim'
```

---

## 常见场景速查表

| 场景 | 症状 | 解决方法 |
|------|------|---------|
| 修改 Lua 配置后未生效 | 配置更改但行为不变 | `rm -rf ~/.cache/nvim/luac` |
| 移动/重命名 Lua 模块 | 模块找不到错误 | `rm -rf ~/.cache/nvim/luac` |
| Nix 配置切换后异常 | 插件加载失败、配置混乱 | `rm -rf ~/.cache/nvim/` |
| 插件更新后出错 | 插件功能异常、报错 | `rm -rf ~/.local/share/nvim/lazy/` |
| 完全混乱无法启动 | 多种错误交织 | 彻底清除所有缓存 |

---

## 技术细节补充

### Lua 缓存文件命名规则

缓存文件名是原始路径的 URL 编码：
- 原始路径：`/Users/moonshot/.config/nvim/lua/config/lsp/init.lua`
- 缓存名：`%2fUsers%2fmoonshot%2f.config%2fnvim%2flua%2fconfig%2flsp%2finit.luac`

### 缓存加载优先级

1. `package.preload` - 预加载表
2. `cache_loader` - 字节码缓存加载器
3. `cache_loader_lib` - 库缓存加载器
4. 文件系统搜索 - 原始 `.lua` 文件

错误信息中的顺序反映了 Neovim 的模块加载尝试顺序。

---

## 参考信息

- **缓存目录**: `~/.cache/nvim/luac/`
- **插件目录**: `~/.local/share/nvim/lazy/`
- **状态目录**: `~/.local/state/nvim/`
- **相关技术**: LuaJIT, Lua 5.1, Nix, Home Manager
