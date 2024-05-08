local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		LAZY_PLUGIN_SPEC,
	},
	install = {
		colorscheme = { "tokyonight", "default" },
	},
	ui = {
		border = "rounded",
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
})

-- local wk = require("which-key")
-- wk.register({
-- 	["<leader>Li"] = { "<cmd>Lazy install<cr>", "Install" },
-- 	["<leader>Ls"] = { "<cmd>Lazy sync<cr>", "Sync" },
-- 	["<leader>LS"] = { "<cmd>Lazy clear<cr>", "Status" },
-- 	["<leader>Lx"] = { "<cmd>Lazy clean<cr>", "Clean" },
-- 	["<leader>Lu"] = { "<cmd>Lazy update<cr>", "Update" },
-- 	["<leader>Lp"] = { "<cmd>Lazy profile<cr>", "Profile" },
-- 	["<leader>Ll"] = { "<cmd>Lazy log<cr>", "Log" },
-- 	["<leader>Ld"] = { "<cmd>Lazy debug<cr>", "Debug" },
-- })
