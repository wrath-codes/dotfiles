return {
  -- Disable LazyVim's indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  
  -- Add hlchunk instead
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        notify = false,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─",
        },
        style = {
          { fg = "#806d9c" },
        },
      },
      indent = {
        enable = true,
        chars = {
          "│",
        },
        style = {
          { fg = "#2f334d" },
        },
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
  },
}
