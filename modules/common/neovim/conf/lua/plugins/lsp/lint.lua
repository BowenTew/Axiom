-- ============================================================================
-- nvim-lint - 代码检查
-- 比 none-ls 更轻量，专注于 linting
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters_by_ft = {
      lua = { "luacheck" },
      python = { "flake8" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    },
  },
  config = function(_, opts)
    require("lint").linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
