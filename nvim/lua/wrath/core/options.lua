Map = vim.keymap.set
MapNR = vim.keymap.nnoremap
Cmd = vim.cmd
Opt = vim.opt
AuGroup = vim.api.nvim_create_augroup
AutoCmd = vim.api.nvim_create_autocmd
Exec = vim.api.nvim_exec

-- global options
vim.g.mapleader = " " -- set leader key to space

-- line numbers
Opt.relativenumber = true -- show relative line numbers
Opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
Opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
Opt.shiftwidth = 2    -- 2 spaces for indent width
Opt.expandtab = true  -- expand tab to spaces
Opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
Opt.wrap = false -- disable line wrapping

-- search settings
Opt.ignorecase = true -- ignore case when searching
Opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
Opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
Opt.termguicolors = true
Opt.background = "dark" -- colorschemes that can be light or dark will be made dark
Opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
Opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
Opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
Opt.splitright = true -- split vertical window to the right
Opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
Opt.swapfile = false
