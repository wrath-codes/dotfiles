-- VSCode Neovim Integration
-- Only loaded when running inside VSCode

if not vim.g.vscode then
  return
end

-- Load utility functions first (defines VSCodeMap, VSCodeNotify, etc.)
require("vscode-config.util")

-- Load API functions (defines global command functions)
require("vscode-config.api")

-- Load keymaps (uses the API functions)
require("vscode-config.keymaps")
