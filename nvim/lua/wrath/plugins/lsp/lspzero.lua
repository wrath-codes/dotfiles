local M = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ -- Optional
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
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
	"jdtls",
	"elixirls",
	"tflint",
	"dockerls",
	"bashls",
	"marksman",
	"lemminx",
}

local function lsp_keymaps(bufnr)
	local keymap_opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, vim.tbl_deep_extend("force", keymap_opts, { desc = "Goto Declaration" }))

	vim.keymap.set(
		"n",
		"gd",
		"<cmd>Telescope lsp_definitions<CR>",
		vim.tbl_deep_extend("force", keymap_opts, { desc = "Goto Definition" })
	)

	vim.keymap.set(
		"n",
		"gi",
		"<cmd>Telescope lsp_implementations<CR>",
		vim.tbl_deep_extend("force", keymap_opts, { desc = "Goto Implementation" })
	)

	vim.keymap.set(
		"n",
		"gt",
		"<cmd>Telescope lsp_type_definitions<CR>",
		vim.tbl_deep_extend("force", keymap_opts, { desc = "Goto Type Definition" })
	)

	vim.keymap.set(
		"n",
		"gr",
		"<cmd>Telescope lsp_references<CR>",
		vim.tbl_deep_extend("force", keymap_opts, { desc = "Goto References" })
	)

	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float()
	end, vim.tbl_deep_extend("force", keymap_opts, { desc = "Open Diagnostics" }))

	vim.keymap.set(
		"n",
		"gL",
		"<cmd>Telescope diagnostics bufnr=0<CR>",
		vim.tbl_deep_extend("force", keymap_opts, { desc = "List Diagnostics" })
	)

	vim.keymap.set("n", "gH", function()
		vim.lsp.buf.signature_help()
	end, vim.tbl_deep_extend("force", keymap_opts, { desc = "Signature Help" }))

	vim.keymap.set("n", "<leader>gh", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end, vim.tbl_deep_extend("force", keymap_opts, { desc = "Hover" }))
	vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end, vim.tbl_deep_extend("force", keymap_opts, { desc = "Hover" }))
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
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
	local lsp = require("lsp-zero")
	local icons = require("wrath.utils.icons")

	lsp.on_attach(function(client, bufnr)
		lsp_keymaps(bufnr)
	end)

	lsp.set_sign_icons({
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warning,
		info = icons.diagnostics.Information,
		hint = icons.diagnostics.Hint,
	})

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

	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = M.servers,
		handlers = {
			lsp.default_setup,

			lua_ls = function()
				local lua_opts = require("wrath.plugins.lsp.settings.lua_ls")
				lspconfig.lua_ls.setup(lua_opts)
			end,

			cssls = function()
				local css_opts = require("wrath.plugins.lsp.settings.cssls")
				lspconfig.cssls.setup(css_opts)
			end,

			jsonls = function()
				local json_opts = require("wrath.plugins.lsp.settings.jsonls")
				lspconfig.jsonls.setup(json_opts)
			end,

			yamlls = function()
				local yaml_opts = require("wrath.plugins.lsp.settings.yamlls")
				lspconfig.yamlls.setup(yaml_opts)
			end,
		},
	})
end

return M
