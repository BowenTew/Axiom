return {
  { import = "plugins.finder" },
  { import = "plugins.git" },
  { import = "plugins.ui" },
  -- 直接导入具体 LSP 插件，避免递归扫描到 `plugins.lsp.servers`
  { import = "plugins.lsp.mason" },
  { import = "plugins.lsp.lspconfig" },
  { import = "plugins.lsp.mason-lspconfig" },
  { import = "plugins.lsp.luasnip" },
  { import = "plugins.lsp.conform" },
  { import = "plugins.lsp.lint" },
  { import = "plugins.editor" },
  { import = "plugins.base" },
  -- { import = "plugins.languages" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    enabled = AeonVim.features.session.enabled,
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize" },
      pre_save = nil,
      save_empty = false,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
