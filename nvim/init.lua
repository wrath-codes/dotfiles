require("wrath.core")

if vim.g.vscode then
    require("wrath.lazy")
    require("wrath.vscode.util")
    require("wrath.vscode.autocmds")
    require("wrath.vscode.api")
    require("wrath.vscode.keymaps")
else
    require("wrath.lazy")
    require("wrath.neovim.keymaps")
end
