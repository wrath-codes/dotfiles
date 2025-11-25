return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      -- transparent_background = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
      integrations = {
        navic = {
          enabled = true,
          custom_bg = "NONE", -- "lualine" will set background to mantle
        },
      },
      custom_highlights = function(colors)
        return {
          -- Make completion menu transparent
          Pmenu = { bg = colors.none },
          PmenuSel = { bg = colors.surface0, fg = colors.text },
          PmenuSbar = { bg = colors.none },
          PmenuThumb = { bg = colors.surface0 },

          -- Make LSP floating windows transparent
          NormalFloat = { bg = colors.none },
          FloatBorder = { bg = colors.none, fg = colors.overlay0 },

          -- Make which-key transparent
          WhichKeyFloat = { bg = colors.none },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
