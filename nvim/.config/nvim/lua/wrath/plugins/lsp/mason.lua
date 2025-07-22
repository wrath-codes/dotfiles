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
	"ruff",
}

M.tools = {
	"prettier", -- prettier formatter
	"stylua", -- lua formatter
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
	"markdownlint-cli2",
	"markdown-toc",
}

function M.config()
	local wk = require("which-key")
	wk.add({
		{ "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
	})

	require("mason").setup({
		registries = {
			"github:mason-org/mason-registry",
		},

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
