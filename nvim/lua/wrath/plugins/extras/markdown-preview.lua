local M = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",

	ft = { "markdown" },
}

function M.build()
	vim.fn["mkdp#util#install"]()
end

return M
