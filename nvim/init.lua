Map =  vim.keymap.set 
Cmd = vim.cmd
Opt = vim.opt
AuGroup = vim.api.nvim_create_augroup
AutoCmd = vim.api.nvim_create_autocmd
Exec = vim.api.nvim_exec
VSCodeNotify = vim.fn.VSCodeNotify 
VSCodeCall = vim.fn.VSCodeCall
VSCodeOpts = {noremap = true, silent = true}


require("wrath.core.options")
require("wrath.core.autocmds")
require("wrath.core.keymaps")

require("wrath.lazy")
