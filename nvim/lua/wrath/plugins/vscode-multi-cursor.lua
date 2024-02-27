return {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    vscode = true,
    config = function(_, _)
        require('vscode-multi-cursor').setup { -- Config is optional
            -- Whether to set default mappings
            default_mappings = true,
            -- If set to true, only multiple cursors will be created without multiple selections
            no_selection = false
        }
    end,
}
