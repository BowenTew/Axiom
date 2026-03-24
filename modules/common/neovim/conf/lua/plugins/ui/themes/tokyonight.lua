  -- Tokyonight (默认)
  return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "day",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  }