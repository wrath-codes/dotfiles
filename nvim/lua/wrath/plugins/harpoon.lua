local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local harpoon = require("harpoon")
  local wk = require("which-key")

  wk.register {
    ["<leader>a"] = {function() M.mark_file() end, "Add a file", opts},
    ["<C-e>"] = {function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Toggle Harpoon", opts},
    ["<C-h>"] = {function() harpoon:list():select(1) end, "Harpoon 1", opts },
    ["<C-t>"] = {function() harpoon:list():select(2) end, "Harpoon 2", opts},
    ["<C-n>"] = {function() harpoon:list():select(3) end, "Harpoon 3", opts},
    ["<C-s>"] = {function() harpoon:list():select(4) end, "Harpoon 4", opts},
    ["<leader><C-h>"] = {function() harpoon:list():replace_at(1) end, "Replace Harpoon 1", opts},
    ["<leader><C-t>"] = {function() harpoon:list():replace_at(2) end, "Replace Harpoon 2", opts},
    ["<leader><C-n>"] = {function() harpoon:list():replace_at(3) end, "Replace Harpoon 3", opts},
    ["<leader><C-s>"] = {function() harpoon:list():replace_at(4) end, "Replace Harpoon 4", opts},
  }

  vim.api.nvim_create_autocmd({ "filetype" }, {
    pattern = "harpoon",
    callback = function()
      vim.cmd [[highlight link HarpoonBorder TelescopeBorder]]
      -- vim.cmd [[setlocal nonumber]]
      -- vim.cmd [[highlight HarpoonWindow guibg=#313132]]
    end,
  })
end

function M.mark_file()
  require("harpoon"):list():add()
  vim.notify("󱡅  marked file")
end

return M
