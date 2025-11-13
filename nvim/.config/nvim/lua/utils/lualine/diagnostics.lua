local M = {}

function M.setup()
  local icons = LazyVim.config.icons
  return {
    "diagnostics",

    -- Table of diagnostic sources, available sources are:
    --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    -- or a function that returns a table as such:
    --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    sources = { "nvim_diagnostic", "vim_lsp" },

    -- Displays diagnostics for the defined severity types
    sections = { "error", "warn", "info", "hint" },

    diagnostics_color = {
      -- Same values as the general color option can be used here.
      error = "DiagnosticError", -- Changes diagnostics' error color.
      warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
      info = "DiagnosticInfo", -- Changes diagnostics' info color.
      hint = "DiagnosticHint", -- Changes diagnostics' hint color.
    },
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warning,
      info = icons.diagnostics.Information,
      hint = icons.diagnostics.Hint,
    },
    colored = true, -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = false, -- Show diagnostics even if there are none.
  }
end

return M
