local M = {
	"MysticalDevil/inlay-hints.nvim",
	event = "LspAttach",
	dependencies = { "neovim/nvim-lspconfig" },
}

function M.config()
	require("inlay-hints").setup()
end

return M
