local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		debug = false,
		sources = {
			formatting.stylua,
			formatting.prettier,
			formatting.ruff,
			-- formatting.prettier.with {
			--   extra_filetypes = { "toml" },
			--   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			-- },
			-- formatting.eslint,
			diagnostics.ruff,
			null_ls.builtins.completion.spell,
			null_ls.builtins.diagnostics.markdownlint_cli2,
		},
	})
end

return M
