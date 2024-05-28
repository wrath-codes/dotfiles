local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
	local harpoon = require("harpoon")

	harpoon:setup({})

	vim.keymap.set("n", "<leader>ha", M.mark_file)
	vim.keymap.set("n", "<leader>he", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	vim.keymap.set("n", "7", function()
		harpoon:list():select(1)
	end)
	vim.keymap.set("n", "8", function()
		harpoon:list():select(2)
	end)
	vim.keymap.set("n", "9", function()
		harpoon:list():select(3)
	end)
	vim.keymap.set("n", "0", function()
		harpoon:list():select(4)
	end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-P>", function()
		harpoon:list():prev()
	end)
	vim.keymap.set("n", "<C-S-N>", function()
		harpoon:list():next()
	end)

	vim.api.nvim_create_autocmd({ "filetype" }, {
		pattern = "harpoon",
		callback = function()
			vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
			vim.cmd([[setlocal nonumber]])
			vim.cmd([[highlight HarpoonWindow guibg=#313132]])
		end,
	})
end

function M.mark_file()
	require("harpoon"):list():add()
	vim.notify("󰛢  marked file")
end

return M
