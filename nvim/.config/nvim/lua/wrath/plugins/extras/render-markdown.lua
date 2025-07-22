local M = {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
		heading = {
			sign = false,
			icons = {},
		},
		checkbox = {
			enabled = true,
		},
	},
	ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
}

function M.get_rm_state()
	return require("render-markdown.state").enable
end

function M.set_rm_state(enabled)
	local m = require("render-markdown")
	if enabled then
		m.enable()
	else
		m.disable()
	end
end

function M.toggle_render_markdown()
	local state = M.get_rm_state()
	M.set_rm_state(not state)
end

function M.config()
	local wk = require("which-key")
	local render_markdown = require("render-markdown")
	render_markdown.setup(M.opts)

	wk.add({
		{ "<leader>mr", M.toggle_render_markdown, desc = "Toggle Render Markdown" },
	})
end

return M
