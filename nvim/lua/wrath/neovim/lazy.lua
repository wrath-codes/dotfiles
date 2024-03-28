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
		{ import = "wrath.plugins.nvim-spider" },
		{ import = "wrath.plugins.alpha-nvim" },
		{ import = "wrath.plugins.auto-session" },
		{ import = "wrath.plugins.bufferline" },
		{ import = "wrath.plugins.colorizer" },
		{ import = "wrath.plugins.colorscheme" },
		{ import = "wrath.plugins.comment" },
		{ import = "wrath.plugins.dressing" },
		{ import = "wrath.plugins.elixir-tools" },
		{ import = "wrath.plugins.formatting" },
		{ import = "wrath.plugins.gitsigns" },
		{ import = "wrath.plugins.harpoon" },
		{ import = "wrath.plugins.linting" },
		{ import = "wrath.plugins.lualine" },
		{ import = "wrath.plugins.neogen" },
		{ import = "wrath.plugins.noice" },
		{ import = "wrath.plugins.nvim-autopairs" },
		{ import = "wrath.plugins.nvim-cmp" },
		{ import = "wrath.plugins.nvim-java" },
		{ import = "wrath.plugins.nvim-tree" },
		{ import = "wrath.plugins.nvim-treesitter" },
		{ import = "wrath.plugins.nvim-treesitter-textobjects" },
		{ import = "wrath.plugins.nvim-web-devicons" },
		{ import = "wrath.plugins.telescope" },
		{ import = "wrath.plugins.trouble" },
		{ import = "wrath.plugins.which-key" },
		{ import = "wrath.plugins.lsp" },
	}
}, {
	install = {
		colorscheme = { "tokyonight " },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

vim.cmd([[colorscheme tokyonight]])
