-- Highlight text on yank
AuGroup("YankHighlight", { clear = true })
AutoCmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "200" })
    end,
})

-- Check for spelling in text filetypes
AutoCmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- Remove trailing whitespaces
AutoCmd("BufWritePre", {
    pattern = "",
    command = "%s/\\s\\+$//e",
})

-- Close man and help with just <q>
AutoCmd("FileType", {
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
AutoCmd("BufWritePre", {
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
