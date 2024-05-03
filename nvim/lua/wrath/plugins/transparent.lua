local M = {
  "xiyaowong/transparent.nvim",
}

function M.config()
  local  transparent = require("transparent")

  transparent.setup({
    groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {
    "NvimTreeNormal", "NvimTreBufferLineTabClose", "vimTreeNormalNC",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",

    "IndentBlanklineChar",

    -- make floating windows transparent
    "LspFloatWinNormal",
    "Normal",
    "NormalFloat",
    "Pmenu",
    "Float",
    "FloatBorder",
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptBorder",
    "SagaBorder",
    "SagaNormal",
    "NormalFloat:DiagnosticError",
    }, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

  local wk = require("which-key")

  wk.register{
  ["<leader>Tt"] = { "<cmd>TransparentToggle<cr>", "Toggle Transparency" },
  }
vim.cmd("highlight Pmenu guibg=NONE")

end

return M


