  -- Tokyonight (默认)
  return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = AeonVim.features.ui.transparent.enabled,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  }