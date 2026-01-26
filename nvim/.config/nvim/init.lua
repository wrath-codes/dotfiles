-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load VSCode-specific config when running in VSCode
if vim.g.vscode then
  require("vscode-config")
end
