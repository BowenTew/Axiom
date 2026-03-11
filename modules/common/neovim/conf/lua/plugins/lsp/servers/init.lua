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

  gopls = require("plugins.lsp.servers.go"),
  lua_ls = require("plugins.lsp.servers.lua_ls"),
  rust_analyzer = require("plugins.lsp.servers.rust"),
  ts_ls = require("plugins.lsp.servers.typescript"),
}
