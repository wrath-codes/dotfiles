local M = {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
}

function M.config()
	local wk = require("which-key")
	local mappings = {
		{ "<leader>Tz", group = "Zen Mode" },
		{ "<leader>Tzm", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
	}
	local options = { mode = "n" }
	wk.add(mappings, options)

	require("zen-mode").setup({
		-- write logs to console(command line)
	})
end

return M
