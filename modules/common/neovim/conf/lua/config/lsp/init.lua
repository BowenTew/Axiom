return {
  ["*"] = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
  },

  gopls = require("config.lsp.go"),
  lua_ls = require("config.lsp.lua_ls"),
  rust_analyzer = require("config.lsp.rust"),
  ts_ls = require("config.lsp.typescript"),
}
