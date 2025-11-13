return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}
      
      -- TEMPORARILY DISABLED: Migrating to amp-extras-rs
      -- Add amp-extras to default sources
      -- table.insert(opts.sources.default, "amp-extras")
      
      -- Register amp-extras provider
      -- opts.sources.providers["amp-extras"] = {
      --   name = "amp-extras",
      --   module = "amp-extras.blink.source",
      --   score_offset = 100, -- Higher priority
      -- }
      
      opts.keymap = {
        preset = "enter",

        -- CRITICAL: Navigate with C-j/C-k (NOT Tab/S-Tab)
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        -- Accept with Enter
        ["<CR>"] = { "accept", "fallback" },

        -- Show/hide (C-y for show, C-e for hide)
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
