local M = {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPost", "BufNewFile" },
  -- build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- event = "VeryLazy",
    },
  },
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "gleam" }, -- put the language you want in this array
    ignore_install = { "" },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    modules = {},
    indent = {
      enable = true,
      disable = { "yaml" },
    },
    autopairs = { enable = true },
  }
end

return M
