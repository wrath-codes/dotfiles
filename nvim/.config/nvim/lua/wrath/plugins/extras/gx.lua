local M = {
    "chrishrb/gx.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    submodules = false,
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
}

function M.init()
  vim.g.netrw_nogx = 1 -- disable netrw gx
end



return M
