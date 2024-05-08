local M = {
  "xiyaowong/transparent.nvim",
}

function M.config()
  local transparent = require("transparent")

  transparent.setup({
    groups = { -- table: default groups
      'Normal', 'NormalNC', 'NormalSB', 'Comment', 'Constant', 'Special', 'Identifier',
      'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
      'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
      'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
      'EndOfBuffer', 'Title', 'Question', 'WarningMsg', 'ErrorMsg', 'MoreMsg',
    },
    extra_groups = {
      "NvimTreeNormal", "NvimTreBufferLineTabClose", "vimTreeNormalNC",
      "BufferlineBufferSelected",
      "BufferLineFill",
      "BufferLineBackground",
      "BufferLineSeparator",
      "BufferLineIndicatorSelected",
      "IndentBlanklineChar",
      "MsgArea",
      "NonText",

      -- make floating windows transparent
      "LspFloatWinNormal",
      "Normal",
      "NormalFloat",
      "Pmenu",
      "Special",
      "PmenuSel",
      "Float",
      "FloatBorder",
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePromptBorder",
      "SagaBorder",
      "SagaNormal",
      "NormalFloat:DiagnosticError",
      "HarpoonInactive",
      "HarpoonActive",
      "HarpoonNumberActive",
      "HarpoonNumberInactive",
      "HarpoonEmpty",
      "HarpoonNumberEmpty",
      "TabLineFill",
      "FidgetTitle",
      "FidgetTask",
      "NoiceMini",
      "DiagnosticSignWarn",
      "NoiceFormatEvent",
      "NoiceFormatKind",
      "NoiceFormatLevelDebug",
      "NoiceFormatLevelError",
      "NoiceFormatLevelInfo",
      "NoiceFormatLevelWarn",
      "NoiceFormatLevelTrace",
      "NoiceFormatLevelOff",
      "NoiceFormatLevelProgressDone",
      "NoiceFormatLevelProgressTodo",
      "NoiceLspProgressClient",
      "NoiceLspProgressSpinner",
      "NoiceLspProgressTitle",
      "NoiceMini",
      "NoicePopup",
      "NoicePopupBorder",
      "NoicePopupmenu",
      "NoicePopupmenuBorder",
      "NoicePopupmenuMatch",
      "NoicePopupmenuSelected",
      "NoiceScrollbar",
      "NoiceScrollbarThumb",
    },                   -- table: additional groups that should be cleared
    exclude_groups = {}, -- table: groups you don't want to clear
  })

  local wk = require("which-key")

  wk.register {
    ["<leader>TT"] = { "<cmd>TransparentToggle<cr>", "Toggle Transparency" },
  }
  vim.cmd("highlight Pmenu guibg=NONE")
end

return M
