local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup({
    default_file_explorer = true,
    view_options =  {
      show_hidden = false,
    },
    float = {
      max_height = 40,
      max_width = 80,
    },
  })
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
