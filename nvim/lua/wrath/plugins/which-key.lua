local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "LSP" },
    L = { name = "Lazy" },
    t = { name = "Test" },
    T = { name = "Toggle" },
    s = { name = "Treesitter" },
    c = { name = "Lab" },
    w = {
      name = "Window",
      s = {
        name = "Split",
        v = { "<C-w>v", "Vertical" },
        h = { "<C-w>s", "Horizontal" },
        e = { "<C-w>=", "Equal" },
        c = { "<cmd>close<CR>", "Close" },
      },
      t = {
        name = "Tab",
        c = { "<cmd>tabclose<CR>", "Close" },
        n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
        N = { "<cmd>tabnew %<cr>", "New Tab" },
        o = { "<cmd>tabonly<cr>", "Only" },
        h = { "<cmd>-tabmove<cr>", "Move Left" },
        l = { "<cmd>+tabmove<cr>", "Move Right" },
      },
    }
  }

  local which_key = require("which-key")
  which_key.setup({
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  })

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
  which_key.register({
    ["<Tab>"] = { "<cmd>tabn<CR>", "Go to next tab" },
    ["<S-Tab>"] = { "<cmd>tabp<CR>", "Go to previous tab" },
  }, opts)
end

return M
