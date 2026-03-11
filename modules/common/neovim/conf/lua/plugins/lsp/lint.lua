-- ============================================================================
-- nvim-lint - 代码检查
-- 比 none-ls 更轻量，专注于 linting
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters_by_ft = {
      -- lua = { "luacheck" },
      -- python = { "pyright" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        local ft = vim.bo.filetype
        -- filetype 没配置 linter 时直接跳过，避免在 neo-tree 等特殊 buffer 里报错
        if not lint.linters_by_ft[ft] then return end
        lint.try_lint()
      end,
    })
  end,
}
