return {
  -- Go语言服务器
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "gopls", -- Go语言服务器
      },
    },
  },

  -- Go语言工具
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua", -- GUI支持
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- LSP配置
        lsp_cfg = false, -- 使用我们自己的lspconfig配置
        lsp_gofumpt = true, -- 使用gofumpt格式化
        lsp_on_attach = true,
        lsp_codelens = true,
        lsp_diag_hdlr = true,
        lsp_keymaps = false, -- 使用我们自己的键绑定
        
        -- 工具配置
        goimports = "gopls", -- 使用gopls进行import管理
        gofmt = "gopls", -- 使用gopls格式化
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        icons = { breakpoint = "🧘", currentpos = "📍" },
        
        -- 诊断配置
        diagnostic = {
          hdlr = false,
          underline = true,
          virtual_text = { spacing = 0, prefix = "■" },
          signs = true,
          update_in_insert = false,
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- 安装Go工具
  },

  -- Go测试运行器
  {
    "nvim-neotest/neotest-go",
    dependencies = {
      "nvim-neotest/neotest",
    },
  },

  -- Go调试适配器
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = "",
        },
      })
    end,
    ft = "go",
  },

  -- Go结构体标签
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    ft = { "go", "gomod" },
  },

  -- Go覆盖率
  {
    "ravenxrz/DAPInstall.nvim",
    config = function()
      require("dap-install").config("go_delve", {})
    end,
  },
}
