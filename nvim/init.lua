-- Add core and Initialize plugin table
require("wrath.lazy.launch")
require("wrath.core.options")
require("wrath.core.keymaps")

-- Utils
require("wrath.utils.transparent") -- Add transparency

-- Plugins
spec("wrath.plugins.colorscheme")
spec("wrath.plugins.devicons")
spec("wrath.plugins.treesitter")
spec("wrath.plugins.cmp")
spec("wrath.plugins.lsp.mason")
spec("wrath.plugins.lsp.lspconfig")

spec("wrath.plugins.schemastore")
spec("wrath.plugins.which-key")

-- Start Lazy
require("wrath.lazy.lazy")

