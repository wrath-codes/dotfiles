if vim.g.vscode then return {} end

return {
  "saghen/blink.indent",
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  config = function()
    require("blink.indent").setup({
      blocked = {
        -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
        buftypes = { include_defaults = true },
        -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
        filetypes = { include_defaults = true },
      },

      mappings = {
        -- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
        border = "both",
        -- set to '' to disable
        -- textobjects (e.g. `y2ii` to yank current and outer scope)
        object_scope = "ii",
        object_scope_with_border = "ai",
        -- motions
        goto_top = "[i",
        goto_bottom = "]i",
      },

      static = {
        enabled = true,
        char = "▎",
        whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
        priority = 1,
        highlights = { "BlinkIndent" },
      },

      scope = {
        enabled = true,
        char = "▎",
        priority = 1000,
        highlights = {
          "BlinkIndentOrange",
          "BlinkIndentViolet",
          "BlinkIndentBlue",
          "BlinkIndentRed",
          "BlinkIndentCyan",
          "BlinkIndentYellow",
          "BlinkIndentGreen",
        },

        underline = {
          enabled = true,
          highlights = {
            "BlinkIndentOrangeUnderline",
            "BlinkIndentVioletUnderline",
            "BlinkIndentBlueUnderline",
            "BlinkIndentRedUnderline",
            "BlinkIndentCyanUnderline",
            "BlinkIndentYellowUnderline",
            "BlinkIndentGreenUnderline",
          },
        },
      },
    })
  end,
}
