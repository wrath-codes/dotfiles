local M = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",

	ft = { "markdown" },
}

function M.init()
	vim.g.mkdp_filetypes = { "markdown" }
end

return M
