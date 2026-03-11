-- ============================================================================
-- 插件管理器配置 (lazy.nvim)
-- 支持版本快照和回滚机制
-- ============================================================================

-- 更新配置
local updates_config = {
  channel = "stable",                  -- 'nightly' 或 'stable'
  snapshot_file = "lazy_snapshot.lua", -- 插件锁定文件
}

--- 下载 lazy.nvim（首次启动）
local function git_clone_lazy(lazy_dir)
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_dir,
  })
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.api.nvim_echo(
      {{"Error cloning lazy.nvim repository...\n\n" .. output}},
      true, {err = true}
    )
  end
end

--- 首次启动后自动加载关键插件
local function after_installing_plugins_load(plugins)
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyInstall",
    once = true,
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module) pcall(require, module) end, plugins)
    end,
    desc = "Load Mason and Treesitter after Lazy installs plugins",
  })
end

--- 加载快照文件并返回 spec
local function get_lazy_spec()
  local snapshot_filename = vim.fn.fnamemodify(updates_config.snapshot_file, ":t:r")
  local pin_plugins = updates_config.channel == "stable"
  local snapshot_file_exists = vim.uv.fs_stat(
    vim.fn.stdpath("config")
    .. "/lua/"
    .. snapshot_filename
    .. ".lua"
  )
  
  -- 稳定模式下使用快照
  local spec = pin_plugins
      and snapshot_file_exists
      and { { import = snapshot_filename} }
    or {}
  
  -- 合并用户插件
  -- 直接 require `plugins/init.lua`，避免递归导入所有子模块（如 LSP servers 配置文件）
  local user_plugins = require("plugins")
  vim.list_extend(spec, user_plugins)
  -- vim.list_extend(spec, { { import = "lang" } })  -- 预留语言特定配置入口

  return spec
end

--- 设置 lazy.nvim
local function setup_lazy(lazy_dir)
  local spec = get_lazy_spec()

  vim.opt.rtp:prepend(lazy_dir)
  require("lazy").setup({
    spec = spec,
    defaults = {
      lazy = true,
      version = nil, -- 快照优先
    },
    install = {
      colorscheme = { "tokyonight-night", "habamax" },
      missing = true,
    },
    ui = {
      size = { width = 0.8, height = 0.8 },
      border = "rounded",
      title = " Plugin Manager ",
      title_pos = "center",
      pills = true,
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    checker = {
      enabled = updates_config.channel ~= "stable", -- stable 模式下不自动检查
      notify = false,
      frequency = 86400,
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
    -- 将 lockfile 放在 cache 目录（快照优先）
    lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json",
  })
end

-- 主流程
local lazy_dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local is_first_startup = not vim.uv.fs_stat(lazy_dir)

if is_first_startup then
  git_clone_lazy(lazy_dir)
  after_installing_plugins_load({ "nvim-treesitter", "mason" })
  vim.notify("Please wait while plugins are installed...")
end

setup_lazy(lazy_dir)

-- 快捷键
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
