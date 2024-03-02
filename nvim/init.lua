require("wrath.core.options")
require("wrath.core.autocmds")

if vim.g.vscode then
    require("wrath.lazy")
    require("wrath.core.keymaps")
    require("wrath.vscode.util")
    require("wrath.vscode.autocmds")
    require("wrath.vscode.api")
    require("wrath.vscode.keymaps")
else
    require("wrath.lazy")
    require("wrath.core.keymaps")
    require("wrath.neovim.keymaps")
end
