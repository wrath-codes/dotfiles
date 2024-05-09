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
      "MsgArea",


      -- make floating windows transparent
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
      "HarpoonInactive",
      "HarpoonActive",
      "HarpoonNumberActive",
      "HarpoonNumberInactive",
      "HarpoonEmpty",
      "HarpoonNumberEmpty",
      "TabLineFill",
      "FidgetTitle",
      "FidgetTask",
      "NoiceLspProgressTitle",
      "NoiceLspProgressClient",
      "NoiceLspProgressSpinner",
      "NoiceFormatKind",
      "NoiceFormatLevelTrace",
      "NoiceFormatLevelDebug",
      "NoiceFormatLevelInfo",
      "NoiceFormatLevelWarn",
      "NoiceFormatLevelError",
      "NoiceFormatLevelOff",
      "NoiceFormatProgressTodo",
      "NoiceFormatProgressDone",
      "NoiceFormatTitle",
      "NoiceFormatEvent",
      "NoiceFormatDate",
      "NoiceFormatConfirm",
      "NoiceFormatConfirmDefault",
      "NoiceMini",
    },
    exclude_groups = {}, -- table: groups you don't want to clear
  })

  local wk = require("which-key")

  wk.register {
    ["<leader>TT"] = { "<cmd>TransparentToggle<cr>", "Toggle Transparency" },
  }
  vim.cmd("highlight Pmenu guibg=NONE")
  vim.api.nvim_set_hl(0, "NoiceMini", { bg = "none" })
end

return M
