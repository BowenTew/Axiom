-- 全局配置对象
_G.AeonVim = {
  version = "0.1.0",
  colorscheme = "tokyonight-night",
  
  -- 功能开关
  features = {
    ai = {
      copilot = { enabled = false },
      codeium = { enabled = false },
      tabnine = { enabled = false },
      codecompanion = { enabled = false },
    },
    ui = {
      noice = { enabled = true },          -- 实验性 UI
      animations = { enabled = true },       -- 动画效果
      transparent = { enabled = false },     -- 透明背景
    },
    editor = {
      autopairs = { enabled = true },
      surround = { enabled = true },
      comment = { enabled = true },
      indentline = { enabled = true },
    },
    git = {
      gitsigns = { enabled = true },
      diffview = { enabled = true },
      lazygit = { enabled = true },
    },
    lsp = {
      enabled = true,
      format_on_save = false,
      inlay_hints = true,
    },
    completion = {
      engine = "blink",  -- "blink" | "cmp"
      select_first = false,
    },
    finder = {
      engine = "snacks",  -- "snacks" | "telescope" | "fzf"
    },
    filetree = {
      engine = "neo-tree",  -- "neo-tree" | "nvim-tree" | "mini.files"
    },
    statusline = {
      engine = "lualine",  -- "lualine" | "heirline" | "galaxyline"
    },
    tabline = {
      enabled = true,
      engine = "bufferline",  -- "bufferline" | "barbar"
    },
    terminal = {
      enabled = true,
    },
    session = {
      enabled = true,
      auto_save = true,
    },
    debugging = {
      enabled = false,
    },
    testing = {
      enabled = false,
    },
  },
  
  -- 图标配置
  icons = require("utils.icons"),
  
  -- 键位配置
  keys = {
    leader = " ",
    localleader = ",",
  },
}