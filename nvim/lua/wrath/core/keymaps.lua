local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Fix for <C-i>
keymap("n", "<C-i>", "<C-i>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)


-- Keep window centered when going up/down
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines

keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv",opts)

keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)


vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)

keymap("n", "<leader>pv",vim.cmd.Ex, opts)

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)
keymap({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", opts)

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", opts) -- increment
keymap("n", "<leader>-", "<C-x>", opts) -- decrement

-- Replace word under cursor across entire buffer
keymap('n', 'gB', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Select entire file
keymap("n", "==", "gg<S-v>G", opts)

