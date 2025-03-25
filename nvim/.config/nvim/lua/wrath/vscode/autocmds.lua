-- VSCode-specific autocmds
local vscode = require("vscode")

-- Mode change notification autocmd
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        -- Get the current mode
        local mode = vim.api.nvim_get_mode().mode
        local mode_name = ""

        -- Convert Neovim mode to readable name
        if mode == "n" then
            mode_name = "normal"
        elseif mode == "i" then
            mode_name = "insert"
        elseif mode == "v" then
            mode_name = "visual"
        elseif mode == "V" then
            mode_name = "visual"  -- line visual
        elseif mode == "\22" then -- Ctrl+V (block visual)
            mode_name = "visual"  -- block visual
        elseif mode == "c" then
            mode_name = "cmdline"
        elseif mode == "R" then
            mode_name = "replace"
        else
            -- For other modes, just use as is
            mode_name = mode
        end

        -- Use VSCodeNotify to call our extension command
        vscode.action("nvim_ui_plus.setMode ", { mode = mode_name })
    end,
})
