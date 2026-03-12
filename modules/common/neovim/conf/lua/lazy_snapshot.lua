-- ============================================================================
-- 插件版本快照
-- 由 :DistroFreezePluginVersions 命令生成
-- 用于锁定插件到特定版本，确保稳定性
-- ============================================================================

return {
  -- 核心依赖
  { "folke/lazy.nvim", version = "^11" },
  { "nvim-lua/plenary.nvim", commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
  
  -- 主题
  { "folke/tokyonight.nvim", version = "^5" },
  
  -- 图标
  { "nvim-tree/nvim-web-devicons", commit = "e37bb1f81692c32e568e4e96f2b7f8f5a9aafe9c" },
  
  -- 文件树
  { "nvim-neo-tree/neo-tree.nvim", version = "^3" },
  { "MunifTanjim/nui.nvim", version = "^0.4" },
  
  -- 状态栏
  { "nvim-lualine/lualine.nvim", commit = "b431d228b7bbcdaea818bdc3e25b8cdbe861f056" },
  
  -- Buffer 标签
  { "akinsho/bufferline.nvim", version = "^4" },
  
  -- 语法高亮
  { "nvim-treesitter/nvim-treesitter", commit = "42fc28ba918343ebfd5565147a42a26580579482" },
  
  -- LSP
  { "neovim/nvim-lspconfig", version = "^2" },
  { "mason-org/mason.nvim", version = "^2" },
  { "mason-org/mason-lspconfig.nvim", version = "^2" },
  
  -- 补全
  { "saghen/blink.cmp", version = "^1" },
  
  -- 模糊查找
  { "nvim-telescope/telescope.nvim", version = "^1" },
  { "nvim-telescope/telescope-fzf-native.nvim", commit = "cf48d4dfce44e0b9a2e19a008d6ec6ea6f01a83b" },

  -- Git
  { "lewis6991/gitsigns.nvim", version = "^2" },
  { "sindrets/diffview.nvim", version = "^1" },
  { "kdheepak/lazygit.nvim", version = "^1" },
  { "akinsho/git-conflict.nvim", version = "^2" },
  
  -- 编辑器增强
  { "windwp/nvim-autopairs", commit = "59bce2eef357189c3305e25bc6dd2d138c1683f5" },
  { "numToStr/Comment.nvim", commit = "e30b7f2008e52442154b66f7c519bfd2f1e32acb" },
  { "kylechui/nvim-surround", commit = "ec2dc767fa9b8c4d330d5b9a8ec74f6e51794a68" },
  { "lukas-reineke/indent-blankline.nvim", version = "^3" },
  
  -- 启动页
  { "goolord/alpha-nvim", commit = "a9d8fb72213c8b461e791409e7feabb74eb6ce73" },
  
  -- 终端
  { "akinsho/toggleterm.nvim", version = "^3" },
  
  -- 会话管理
  { "Shatur/neovim-session-manager", version = "^1" },
  
  -- 通知
  { "rcarriga/nvim-notify", version = "^4" },
}
