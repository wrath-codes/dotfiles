require("wrath.core.options")
require("wrath.core.autocmds")

if vim.g.vscode then
    require("wrath.vscode.lazy")
    require("wrath.core.keymaps")
    require("wrath.vscode.util")
    require("wrath.vscode.autocmds")
    require("wrath.vscode.api")
    require("wrath.vscode.keymaps")
else
    require("wrath.neovim.lazy")
    require("wrath.core.keymaps")
    require("wrath.neovim.keymaps")
end
