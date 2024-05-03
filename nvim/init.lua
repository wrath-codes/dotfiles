-- Add core and Initializeplugin table
require "wrath.lazy.launch"
require "wrath.core.options"
require "wrath.core.keymaps"
require "wrath.core.autocmds"

-- Utils

-- Plugins
spec "wrath.plugins.alpha"
spec "wrath.plugins.colorscheme"
spec "wrath.plugins.transparent"
spec "wrath.plugins.devicons"
spec "wrath.plugins.diffview"
spec "wrath.plugins.treesitter"
spec "wrath.plugins.lsp.mason"
spec "wrath.plugins.lsp.lspconfig"
spec "wrath.plugins.lsp.none-ls"
spec "wrath.plugins.cmp"
spec "wrath.plugins.schemastore"
spec "wrath.plugins.autopairs"
spec "wrath.plugins.autotag"
spec "wrath.plugins.project"

spec "wrath.plugins.gitsigns"
spec "wrath.plugins.neogit"
spec "wrath.plugins.harpoon"
spec "wrath.plugins.harpoon-lualine"
spec "wrath.plugins.navic"
spec "wrath.plugins.breadcrumbs"
spec "wrath.plugins.lualine"
spec "wrath.plugins.comment"
spec "wrath.plugins.nvimtree"
spec "wrath.plugins.telescope"
spec "wrath.plugins.which-key"
spec "wrath.plugins.illuminate"
spec "wrath.plugins.neotest"
spec "wrath.plugins.toggleterm"

-- Extras
spec "wrath.plugins.extras.copilot"
spec "wrath.plugins.extras.cmp-tabnine"
spec "wrath.plugins.extras.hlchunk"
spec "wrath.plugins.extras.gx"
spec "wrath.plugins.extras.hop"
spec "wrath.plugins.extras.lab"
spec "wrath.plugins.extras.modicator"
spec "wrath.plugins.extras.oil"
spec "wrath.plugins.extras.tabby"
spec "wrath.plugins.extras.ufo"
spec "wrath.plugins.extras.neotab"
spec "wrath.plugins.extras.gitlinker"
spec "wrath.plugins.extras.zenmode"
spec "wrath.plugins.extras.twilight"
spec "wrath.plugins.extras.fidget"

-- Start Lazy
require "wrath.lazy.lazy"

