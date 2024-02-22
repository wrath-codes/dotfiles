local cmd = vim.cmd -- for calling vim commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local exec = vim.api.nvim_exec -- for executing vimscript

-- Highlight text on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "200" })
	end,
})

-- VSCode Neavim colors UI
if vim.g.vscode then
 vim.api.nvim_exec(
 	[[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')
        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction
    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
    augroup END
]],
	false
)
else

end

-- Check for spelling in text filetypes
autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- Close man and help with just <q>
autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"lspinfo",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file where some intermediate directory does not exist
autocmd("BufWritePre", {
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Remove trailing whitespaces
autocmd("BufWritePre", {
	pattern = "",
	command = "%s/\\s\\+$//e",
})
