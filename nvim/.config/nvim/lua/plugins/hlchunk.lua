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
        duration = 100,
        delay = 50,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─",
        },
        style = {
          "#8839ef", -- Mauve
          "#d20f39", -- Red
        },
      },
    },
  },
  indent = {
    enable = false,
    line_num = {
      enable = true,
    },
    blank = {
      enable = false,
    },
  },
}
