local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- lua functions that many plugins use
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"astro",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
	"tailwindcss",
	"graphql",
	"emmet_ls",
	"rust_analyzer",
	"eslint",
	"taplo",
	"prismals",
	"lexical",
	"tflint",
	"dockerls",
	"bashls",
	"lemminx",
	"jdtls",
	-- "pyright",
	"basedpyright",
	"ruff_lsp",
	-- "pylyzer",
}

M.tools = {
	"prettier", -- prettier formatter
	"stylua", -- lua formatter
	"isort", -- python formatter
	"black", -- python formatter
	"pylint", -- python linter
	"flake8", -- python linter
	"ruff", -- python linter & formatter
	"eslint_d", -- eslint
	"standardrb",
	"prettierd",
	"ktlint",
	"google-java-format",
	"htmlbeautifier",
	"beautysh",
	"buf",
	"yamlfix",
	"taplo",
	"shellcheck",
}

function M.config()
	local wk = require("which-key")
	wk.add({
		{ "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
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

	require("mason-lspconfig").setup({
		ensure_installed = M.servers,
	})

	require("mason-tool-installer").setup({
		ensure_installed = M.tools,
	})
end

return M
