-- set leader key to space
vim.g.mapleader = " "

-- General KeyMaps -------------------
-- use jk to exit insert mode
Map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
Map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
Map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
Map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- VIM COMMANDS
-- Clear search with <esc>
Map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>")

Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
Map("x", "k", ":move '<-2<cr>gv-gv")
Map("x", "J", ":move '>+1<CR>gv-gv")
