local M = {}

function M.setup()
  local icons = LazyVim.config.icons
  return {
    "diff",
    colored = true, -- Displays a colored diff status if set to true
    diff_color = {
      -- Same color values as the general color option can be used here.
      added = "DiagnosticOk", -- Changes the diff's added color
      modified = "DiagnosticWarn", -- Changes the diff's modified color
      removed = "DiagnosticError", -- Changes the diff's removed color you
    },
    symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed }, -- Changes the symbols used by the diff.
    source = require("gitsigns").diffthis(),
    -- It must return a table as such:
    --   { added = add_count, modified = modified_count, removed = removed_count }
    -- or nil on failure. count <= 0 won't be displayed.
  }
end

return M
