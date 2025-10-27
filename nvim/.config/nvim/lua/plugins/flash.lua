return {
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = true,
          keys = { "f", "F", "t", "T" },
        },
      },
    },
    keys = {
      -- Disable default s/S mappings (conflict with surround)
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
      
      -- Use f/F/t/T for Flash (like your old Hop setup)
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "F", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "t", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "T", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      
      -- Keep these Flash features
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      { "<c-space>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
}

