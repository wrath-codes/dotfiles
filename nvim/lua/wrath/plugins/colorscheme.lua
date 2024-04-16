local M = {
  -- "LunarVim/primer.nvim",
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    transparent = true,
    style = "moon",
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
}

function M.config()
  vim.cmd.colorscheme "tokyonight"
  Transparent()
end

return M
