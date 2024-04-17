-- Add core and Initializeplugin table
require("wrath.lazy.launch")
require("wrath.core.options")
require("wrath.core.keymaps")

-- Utils
--require("wrath.utils.transparent") -- Add transparency

-- Plugins
spec("wrath.plugins.colorscheme")
spec("wrath.plugins.transparent")
spec("wrath.plugins.devicons")
spec("wrath.plugins.treesitter")
spec("wrath.plugins.lsp.mason")
spec("wrath.plugins.lsp.lspconfig")
spec("wrath.plugins.lsp.none-ls")
spec("wrath.plugins.cmp")
spec("wrath.plugins.schemastore")

spec("wrath.plugins.lualine")
spec("wrath.plugins.comment")
spec("wrath.plugins.nvimtree")
spec("wrath.plugins.telescope")
spec("wrath.plugins.which-key")

-- Extras
spec("wrath.plugins.extras.copilot")

-- Start Lazy
require("wrath.lazy.lazy")

