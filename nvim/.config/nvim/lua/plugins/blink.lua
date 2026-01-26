if vim.g.vscode then return {} end

return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}

      -- amp-extras @ mentions (for message buffers)
      table.insert(opts.sources.default, "amp")
      opts.sources.providers["amp"] = {
        name = "amp",
        module = "amp_extras.blink.source",
        score_offset = 100,
      }

      -- AmpTab is now standalone ghost text (not a blink.cmp source)
      -- Keymaps are set by amp_extras.amptab.setup() with default_keymaps = true:
      --   gan/gap/gaa/gad/gat (normal mode)
      --   <C-a>/<C-l>/<C-w> (insert mode)

      opts.keymap = {
        preset = "enter",

        -- Navigate with C-j/C-k
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        -- Accept with Enter or Tab
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },

        -- Show/hide
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },

        -- Scroll documentation
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        -- Snippets
        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },
      }
    end,
  },
}
