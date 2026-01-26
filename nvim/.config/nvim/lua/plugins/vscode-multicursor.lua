if vim.g.vscode then
    return {
        'vscode-neovim/vscode-multi-cursor.nvim',
        event = 'VeryLazy',
        cond = not not vim.g.vscode,
        opts = {},
    }
else
    return {}
end
