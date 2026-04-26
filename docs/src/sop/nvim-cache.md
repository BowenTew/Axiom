# Neovim Lua 模块缓存问题

## 问题表现

启动 Neovim 时，LSP 配置加载失败，报错如下：

```
Failed to load `plugins.lsp.lspconfig`

... module 'config.lsp.vuels' not found:
    no field package.preload['config.lsp.vuels']
    cache_loader: module 'config.lsp.vuels' not found
    cache_loader_lib: module 'config.lsp.vuels' not found
```

**关键特征：**
- 错误指向的模块名（`vuels`）与实际配置中的内容（`vtsls`）不符
- 使用了 Nix + Home Manager 管理 Neovim 配置

## 根本原因

Neovim 的 Lua 字节码缓存（`.luac` 文件）未正确刷新，导致加载了旧的编译结果。

### LuaJIT/Lua 5.1 缓存机制

- Neovim 使用 LuaJIT 或 Lua 5.1
- 为加速启动，将 Lua 文件编译为字节码缓存到 `~/.cache/nvim/luac/`
- 缓存文件名经过 URL 编码

### Nix 符号链接的复杂性

- 配置文件通过符号链接指向 Nix Store
- 当 Nix Store 路径变化时，缓存可能指向旧位置

## 解决方案

### 快速解决（推荐）

```bash
# 清除 Lua 字节码缓存
rm -rf ~/.cache/nvim/luac

# 重启 Neovim
nvim
```

### 进阶解决

```bash
# 1. 清除所有 Neovim 缓存
rm -rf ~/.cache/nvim/

# 2. 清除 lazy.nvim 插件缓存（会重新下载插件）
rm -rf ~/.local/share/nvim/lazy/

# 3. 重启 Neovim
nvim
```

### 彻底清除（最后手段）

```bash
rm -rf ~/.cache/nvim/
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
nvim
```

## 预防措施

### Home Manager 激活脚本

```nix
home.activation.clearNvimCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  rm -rf "${config.home.homeDirectory}/.cache/nvim/luac"
'';
```

### Shell 别名

```bash
alias nvim-clean='rm -rf ~/.cache/nvim/luac && nvim'
```

## 常见场景速查

| 场景 | 症状 | 解决方法 |
|------|------|---------|
| 修改 Lua 配置后未生效 | 配置更改但行为不变 | `rm -rf ~/.cache/nvim/luac` |
| 移动/重命名 Lua 模块 | 模块找不到错误 | `rm -rf ~/.cache/nvim/luac` |
| Nix 配置切换后异常 | 插件加载失败、配置混乱 | `rm -rf ~/.cache/nvim/` |
| 插件更新后出错 | 插件功能异常、报错 | `rm -rf ~/.local/share/nvim/lazy/` |
| 完全混乱无法启动 | 多种错误交织 | 彻底清除所有缓存 |

## 技术细节

### 缓存文件命名

- 原始路径：`/Users/moonshot/.config/nvim/lua/config/lsp/init.lua`
- 缓存名：`%2fUsers%2fmoonshot%2f.config%2fnvim%2flua%2fconfig%2flsp%2finit.luac`

### 加载优先级

1. `package.preload`
2. `cache_loader` — 字节码缓存
3. `cache_loader_lib` — 库缓存
4. 文件系统搜索 `.lua` 文件
