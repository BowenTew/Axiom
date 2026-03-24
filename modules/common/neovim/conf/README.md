# AeonVim - Neovim 配置

模块化 Neovim 配置框架，支持版本锁定和回滚机制。

## 🎯 设计理念

| 来源 | 借鉴的优点 |
|------|-----------|
| **AstroNvim** | 美观的 UI 设计、模块化结构 |
| **LazyVim** | 合理的默认配置、灵活的扩展机制 |
| **LunarVim** | 独立隔离的运行环境、版本锁定 |
| **NormalNvim** | 稳定性优先、热重载、回滚机制 |
| **NvChad** | 极速启动、丰富的主题 |
| **Ecovim** | 前端开发优化、AI 集成 |

## 📁 目录结构

```
~/.config/nvim/
├── init.lua                    # 入口文件
├── lua/
│   ├── config/
│   │   ├── options.lua         # 基础选项
│   │   ├── keymaps.lua         # 键位映射
│   │   ├── autocmds.lua        # 自动命令
│   │   └── lazy.lua            # 插件管理器
│   ├── plugins/                # 插件配置
│   │   ├── init.lua            # 插件入口
│   │   ├── alpha.lua           # 启动页
│   │   ├── editor/             # 编辑器插件
│   │   ├── ui/                 # UI 插件
│   │   ├── lsp/                # LSP 相关
│   │   ├── git/                # Git 相关
│   │   ├── finder/             # 查找插件
│   │   └── lang/               # 语言支持
│   ├── core/                   # 核心功能
│   ├── lsp/                    # LSP 配置
│   ├── lang/                   # 语言特定配置
│   ├── utils/                  # 工具函数
│   │   ├── icons.lua           # 图标定义
│   │   ├── globals.lua         # 全局函数
│   │   └── functions.lua       # 工具函数
│   └── internal/               # 内部模块
│       └── cursorword.lua      # 光标单词高亮
└── after/plugin/               # 后加载配置
```

## ⚙️ 全局配置对象

通过修改 `AeonVim` 对象来自定义配置：

```lua
-- lua/config/global.lua
AeonVim = {
  version = "0.1.0",
  colorscheme = "tokyonight-night",
  
  -- 图标配置
  icons = require("utils.icons"),
  
  -- 键位配置
  keys = {
    leader = " ",
    localleader = ",",
  },
}
```

所有插件默认启用，如需禁用某个插件，可在对应插件文件中设置 `enabled = false`。

## ⌨️ 核心快捷键

### 基础操作
| 快捷键 | 功能 |
|--------|------|
| `<Space>` | Leader 键 |
| `<C-s>` | 保存文件 |
| `<C-q>` | 退出 |
| `<Esc>` | 取消高亮 |
| `jk` / `jj` | 退出插入模式 |

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `<C-h/j/k/l>` | 切换窗口 |
| `<C-方向键>` | 调整窗口大小 |
| `<leader>-` | 水平分割 |
| `<leader>\|` | 垂直分割 |

### 文件操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开文件树 |
| `<leader>f` | 查找文件 |
| `<leader>g` | 查找文本 |
| `<leader>r` | 最近文件 |

### 缓冲区
| 快捷键 | 功能 |
|--------|------|
| `<leader>bn` | 下一个缓冲区 |
| `<leader>bp` | 上一个缓冲区 |
| `<leader>bd` | 删除缓冲区 |
| `[b` / `]b` | 缓冲区导航 |

### LSP
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查看引用 |
| `K` | 悬停文档 |
| `<leader>ca` | 代码操作 |
| `<leader>cr` | 重命名 |
| `<leader>cf` | 格式化 |

### 诊断
| 快捷键 | 功能 |
|--------|------|
| `[d` / `]d` | 诊断导航 |
| `[e` / `]e` | 错误导航 |
| `[w` / `]w` | 警告导航 |

## 🚀 快速开始

### 安装

```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆配置
git clone <your-repo> ~/.config/nvim

# 启动 Neovim
nvim
```

### 首次启动

1. lazy.nvim 会自动安装
2. 所有插件会自动下载
3. Treesitter 语法会自动安装
4. LSP 服务器可通过 `:Mason` 安装

## 🔧 自定义配置

### 添加新插件

在 `lua/plugins/` 目录下创建新的配置文件：

```lua
-- lua/plugins/myplugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    config = function()
      require("plugin-name").setup({
        -- 配置
      })
    end,
  },
}
```

### 修改键位

编辑 `lua/config/keymaps.lua`：

```lua
vim.keymap.set("n", "<leader>xx", "<cmd>MyCommand<CR>", { desc = "My description" })
```

### 修改选项

编辑 `lua/config/options.lua`：

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
```

## 📦 预配置插件

### UI
- [x] tokyonight.nvim (主题)
- [x] alpha-nvim (启动页)
- [x] nvim-notify (通知)
- [x] nvim-web-devicons (图标)

### 编辑器
- [ ] nvim-treesitter (语法高亮)
- [ ] nvim-cmp / blink.cmp (补全)
- [ ] nvim-autopairs (自动括号)
- [ ] comment.nvim (注释)
- [ ] nvim-surround (环绕)

### 查找
- [ ] telescope.nvim / snacks.nvim (模糊查找)
- [ ] nvim-tree.lua / neo-tree.nvim (文件树)

### LSP
- [ ] nvim-lspconfig (LSP 配置)
- [ ] mason.nvim (LSP 管理器)
- [ ] none-ls.nvim (格式化/Lint)

### Git
- [ ] gitsigns.nvim (Git 标记)
- [ ] diffview.nvim (差异查看)
- [ ] lazygit (终端集成)

### 终端
- [ ] toggleterm.nvim (终端)

## 🎨 配色方案

内置主题：
- `tokyonight-night` (默认)
- `tokyonight-storm`
- `tokyonight-day`
- `catppuccin`
- `onedark`

切换主题：
```vim
:colorscheme catppuccin
```

## 🔄 版本管理

AeonVim 提供类似 NormalNvim 的版本锁定和回滚机制。

### 更新通道

编辑 `lua/config/lazy.lua`：
```lua
local updates_config = {
  channel = "stable",  -- "stable" 或 "nightly"
  snapshot_file = "lazy_snapshot.lua",
}
```

| 通道 | 说明 |
|------|------|
| `stable` | 使用 `lazy_snapshot.lua` 锁定版本，确保稳定 |
| `nightly` | 使用最新插件版本 |

### 管理命令

| 命令 | 说明 |
|------|------|
| `:DistroFreezePluginVersions` | 将当前插件版本锁定到快照 |
| `:DistroUpdate` | 从 git 更新配置 |
| `:DistroUpdateRevert` | 回滚到上次更新前 |
| `:DistroReadVersion` | 查看当前版本信息 |
| `:DistroReadChangelog` | 查看更新日志 |

### 快捷键

| 快捷键 | 说明 |
|--------|------|
| `<leader>pU` | 更新发行版 |
| `<leader>pR` | 回滚更新 |
| `<leader>pF` | 冻结插件版本 |
| `<leader>pV` | 查看版本信息 |

### 快照文件

`lua/lazy_snapshot.lua` 示例：
```lua
return {
  { "folke/lazy.nvim", version = "^11" },
  { "nvim-treesitter/nvim-treesitter", commit = "42fc28ba..." },
  -- ...
}
```

## 🔌 扩展模块

如需扩展 AI 支持、调试、测试等功能，可在 `lua/plugins/` 下添加对应插件配置文件。

## 📚 参考

- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [NormalNvim](https://github.com/NormalNvim/NormalNvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [Ecovim](https://github.com/ecosse3/nvim)

## 📝 License

MIT
