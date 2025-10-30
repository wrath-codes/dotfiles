return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "second-brain",
          path = vim.fn.expand("~/obsd"),
        },
      },

      notes_subdir = "notes",
      new_notes_location = "notes_subdir",

      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
      },

      ui = {
        enable = false,
      },

      mappings = {
        -- Disable defaults, we'll use <leader>o* commands
      },

      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,

      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- Setup custom Obsidian commands
      require("utils.obsidian.commands").setup()

      -- Register which-key group
      local wk = require("which-key")
      wk.add({
        { "<leader>o", group = "Obsidian" },
      })
    end,
    keys = {
      -- All Obsidian commands under <leader>o*
      -- Global commands (work from anywhere)
      { "<leader>o", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },

      -- Markdown-only commands
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New Note", ft = "markdown" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today", ft = "markdown" },
      { "<leader>od", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian Yesterday", ft = "markdown" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian Backlinks", ft = "markdown" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Obsidian Links", ft = "markdown" },
      { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Obsidian Toggle Checkbox", ft = "markdown" },
      { "<leader>oa", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open in App", ft = "markdown" },
      { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template", ft = "markdown" },
      { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian Follow Link", ft = "markdown" },

      -- Custom snippet capture (visual mode)
      { "<leader>oy", ":'<,'>ObsidianYankSnippet<cr>", desc = "Obsidian Yank Snippet", mode = "v" },
    },
  },
}