-- ============================================================================
-- conform.nvim - 代码格式化
-- 比 none-ls 更轻量，专注于格式化
-- ============================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = function(bufnr)
      if not AeonVim.features.lsp.format_on_save then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
