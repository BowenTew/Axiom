local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

return {
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        fieldalignment = false,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      codelenses = {
        generate = true, -- show the `go generate` lens
        gc_details = true, -- show a code lens toggling the display of gc's choices
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      completeUnimported = true,
      diagnosticsDelay = "500ms",
      experimentalPostfixCompletions = true,
      gofumpt = true, -- use gofumpt instead of gofmt
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      matcher = "Fuzzy",
      semanticTokens = true,
      staticcheck = true,
      symbolMatcher = "Fuzzy",
      usePlaceholders = true,
    },
  },
}
