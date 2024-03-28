local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vm.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import wrath plugins
		{ import = "wrath.plugins.startup-time" },
		{ import = "wrath.plugins.default" },
		{ import = "wrath.plugins.hop" },
		{ import = "wrath.plugins.mini-surround" },
		{ import = "wrath.plugins.vscode-multi-cursor" },
		{ import = "wrath.plugins.nvim-spider" },
	}
}, {
	install = {
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
