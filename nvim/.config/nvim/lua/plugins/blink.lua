return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
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

      -- Add Obsidian snippets source
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      table.insert(opts.sources.default, "obsidian_snippets")

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.obsidian_snippets = {
        name = "Obsidian Snippets",
        module = "utils.blink.obsidian-snippets",
        enabled = true,
        score_offset = 75,
        min_keyword_length = 2,
      }
    end,
  },
}
