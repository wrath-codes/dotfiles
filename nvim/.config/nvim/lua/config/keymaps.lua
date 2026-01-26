-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  return
end

local map = vim.keymap.set

-- ============================================================================
-- CRITICAL KEYBINDINGS (Cannot live without)
-- ============================================================================

-- Code Actions (CRITICAL - overrides LazyVim's <leader>. for scratch buffer)
map("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code Action" })
map("x", "<leader>.", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Select entire file
map("n", "<leader>==", "gg<S-v>G", { desc = "Select Entire File" })

-- Replace word under cursor across entire buffer
map("n", "gB", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word Under Cursor" })

-- Clear search highlights on Escape
map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Clear Highlights and Escape" })

-- Exit terminal mode
map("t", "<C-;>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- ============================================================================
-- MOVEMENT & EDITING
-- ============================================================================

-- Keep cursor centered when searching
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Previous search result (centered)" })
map("n", "*", "*zz", { desc = "Search word forward (centered)" })
map("n", "#", "#zz", { desc = "Search word backward (centered)" })
map("n", "g*", "g*zz", { desc = "Search word forward (no boundaries, centered)" })
map("n", "g#", "g#zz", { desc = "Search word backward (no boundaries, centered)" })

-- Keep cursor centered when jumping half-page
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move lines up/down in visual mode (using C-S-j/C-S-k, see below)
-- Removed J/K mappings to avoid conflict

-- Better paste (don't yank replaced text)
map("x", "p", [["_dP]], { desc = "Paste without yanking" })

-- Tailwind-friendly line navigation (gj/gk for wrapped lines)
map({ "n", "x" }, "j", "gj", { desc = "Down (display line)" })
map({ "n", "x" }, "k", "gk", { desc = "Up (display line)" })

-- ============================================================================
-- TAB NAVIGATION & LINE MOVEMENT
-- ============================================================================

-- Tab/S-Tab to navigate buffers (NOT completion)
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- Disable default Alt-j/Alt-k for moving lines
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

-- Use C-S-j/C-S-k for moving lines in insert and visual mode
map("i", "<C-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-S-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-S-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
