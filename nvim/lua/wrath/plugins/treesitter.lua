local M = {
	"nvim-treesitter/nvim-treesitter",
	-- event = { "BufReadPost", "BufNewFile" },
	-- build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- event = "VeryLazy",
		},
	},
}

function M.config()
	-- which-key setup
	local wk = require("which-key")
	wk.register({
		["<leader>ci"] = { "<cmd>TSConfigInfo<CR>", "Info" },
	})

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"comment",
			"diff",
			"dot",
			"git_rebase",
			"gitcommit",
			"gitattributes",
			"gitignore",
			"make",
			"lua",
			"sql",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"tsx",
			"gleam",
			"java",
			"rust",
			"elixir",
			"astro",
			"dockerfile",
			"html",
			"xhtml",
			"htmldjango",
			"http",
			"go",
			"mermaid",
			"typescript",
			"yaml",
			"javascript",
			"typescript",
			"c",
			"vim",
			"vimdoc",
			"query",
			"erlang",
			"heex",
			"eex",
			"kotlin",
			"jq",
			"json",
			"terraform",
			"ruby",
			"markdown",
		}, -- put the language you want in this array
		ignore_install = { "" },
		sync_install = false,
		highlight = {
			enable = true,
			-- disable = { "markdown" },
			additional_vim_regex_highlighting = false,
		},
		auto_install = true,
		modules = {},
		indent = {
			enable = true,
			disable = { "yaml" },
		},
		autopairs = { enable = true },
		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["at"] = "@class.outer",
					["it"] = "@class.inner",
					["ac"] = "@call.outer",
					["ic"] = "@call.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.inner",
					["a/"] = "@comment.outer",
					["i/"] = "@comment.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["as"] = "@statement.outer",
					["is"] = "@scopename.inner",
					["aA"] = "@attribute.outer",
					["iA"] = "@attribute.inner",
					["aF"] = "@frame.outer",
					["iF"] = "@frame.inner",
				},
			},
		},
	})
end

return M
