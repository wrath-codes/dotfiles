local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- lua functions that many plugins use
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

M.tools = {
	"prettier", -- prettier formatter
	"stylua", -- lua formatter
	"isort", -- python formatter
	"black", -- python formatter
	"pylint", -- python linter
	"eslint_d", -- eslint
	"standardrb",
	"prettierd",
	"ktlint",
	"google-java-format",
	"htmlbeautifier",
	"beautysh",
	"buf",
	"rustfmt",
	"yamlfix",
	"taplo",
	"shellcheck",
}

function M.config()
	local wk = require("which-key")
	wk.register({
		["<leader>lI"] = { "<cmd>Mason<cr>", "Mason Info" },
	})

	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-tool-installer").setup({
		ensure_installed = {
			M.tools,
		},
	})
end

return M
