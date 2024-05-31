local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
}

M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"astro",
	"pyright",
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
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end)
	keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "gL", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
	keymap(bufnr, "n", "gH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
		-- vim.lsp.inlay_hint.enable(bufnr, true)
	end
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
	-- vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

function M.config()
	local wk = require("which-key")

	wk.register({
		["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		["<leader>lf"] = {
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
			"Format File/Range",
		},
		["<leader>ll"] = {
			function()
				require("lint").lint.try_lint()
			end,
			"Format File/Range",
		},
		["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
		["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
		["<leader>lh"] = { "<cmd>lua require('wrath.plugins.lsp.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
		["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
		["<leader>lL"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		["<leader>lR"] = { ":LspRestart<cr>", "Restart LSP" },
	})

	wk.register({
		["<leader>la"] = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
		},
	})

	local lspconfig = require("lspconfig")
	local icons = require("wrath.utils.icons")

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	local svelte_on_attach = function(client, bufnr)
		lsp_keymaps(bufnr)

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				-- Here use ctx.match instead of ctx.file
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})

		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(bufnr, true)
		end
	end

	local graphql_filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }

	local emmet_filetypes =
		{ "html", "css", "sass", "scss", "less", "javascript", "typescript", "javascriptreact", "typescriptreact" }

	local ltex_ls_filetypes = { "tex", "bib", "xhtml" }

	local lexical_config = {
		filetypes = { "elixir", "eelixir", "heex" },
		cmd = { "/my/home/projects/_build/dev/package/lexical/bin/start_lexical.sh" },
		settings = {},
	}

	require("java").setup()
	for _, server_name in pairs(M.servers) do
		local opts = {}
		if server_name == "svelte" then
			opts = {
				on_attach = svelte_on_attach,
				capabilities = M.common_capabilities(),
			}
		else
			opts = {
				on_attach = M.on_attach,
				capabilities = M.common_capabilities(),
			}
		end

		local require_ok, settings = pcall(require, "wrath.plugins.lsp.settings." .. server_name)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server_name == "ltex_ls" then
			opts = vim.tbl_deep_extend("force", {
				filetypes = ltex_ls_filetypes,
			}, opts)
		end

		if server_name == "emmet_ls" then
			opts = vim.tbl_deep_extend("force", {
				filetypes = emmet_filetypes,
			}, opts)
		end

		if server_name == "graphql" then
			opts = vim.tbl_deep_extend("force", {
				filetypes = graphql_filetypes,
			}, opts)
		end

		if server_name == "lua_ls" then
			require("neodev").setup({})
		end

		if server_name == "lexical" then
			if not lspconfig.configs.lexical then
				lspconfig.configs.lexical = {
					default_config = {
						filetypes = lexical_config.filetypes,
						cmd = lexical_config.cmd,
						root_dir = function(fname)
							return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
						end,
						-- optional settings
						settings = lexical_config.settings,
					},
				}
			end
		end

		-- if server_name == "jdtls" then
		-- 	require("java").setup()
		-- end

		lspconfig[server_name].setup(opts)
	end
end

return M
