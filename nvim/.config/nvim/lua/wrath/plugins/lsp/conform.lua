local M = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	},
}

function M.config()
	local conform = require("conform")

	conform.setup({
		formatters = {
			["markdown-toc"] = {
				condition = function(_, ctx)
					for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
						if line:find("<!%-%- toc %-%->") then
							return true
						end
					end
				end,
			},
			["markdownlint-cli2"] = {
				condition = function(_, ctx)
					local diag = vim.tbl_filter(function(d)
						return d.source == "markdownlint"
					end, vim.diagnostic.get(ctx.buf))
					return #diag > 0
				end,
			},
		},

		formatters_by_ft = {
			lua = { "stylua" },
			svelte = { "prettierd", "prettier" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			python = {
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
				-- To organize the imports.
				"ruff_organize_imports",
			},
			json = { "prettierd", "prettier" },
			graphql = { "prettierd", "prettier" },
			java = { "google-java-format" },
			kotlin = { "ktlint" },
			ruby = { "standardrb" },
			markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
			erb = { "htmlbeautifier" },
			html = { "htmlbeautifier" },
			bash = { "beautysh" },
			proto = { "buf" },
			rust = { "rust-analyzer" },
			yaml = { "yamlfix" },
			toml = { "taplo" },
			css = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			sh = { "shellcheck" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	})
end

return M
