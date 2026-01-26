if vim.g.vscode then return {} end

return {
  "LunarVim/breadcrumbs.nvim",
  config = function()
    require("breadcrumbs").setup()
  end,
}
