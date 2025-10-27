return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
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

      completion = {
        nvim_cmp = true,
        min_chars = 2,
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
      
      -- Custom function: Yank selection to Obsidian snippet
      vim.api.nvim_create_user_command("ObsidianYankSnippet", function()
        -- Get visual selection
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local lines = vim.fn.getline(start_pos[2], end_pos[2])
        
        if #lines == 0 then
          vim.notify("No selection", vim.log.levels.WARN)
          return
        end
        
        -- Get first line for title/filename
        local first_line = lines[1]:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
        local title = first_line:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
        
        -- Get current filetype for code block language
        local ft = vim.bo.filetype
        local lang = ft ~= "" and ft or "text"
        
        -- Create markdown content
        local content = {
          "# " .. first_line,
          "",
          "```" .. lang,
        }
        for _, line in ipairs(lines) do
          table.insert(content, line)
        end
        table.insert(content, "```")
        table.insert(content, "")
        
        -- Create file path
        local snippets_dir = vim.fn.expand("~/obsd/snippets")
        vim.fn.mkdir(snippets_dir, "p")
        
        local timestamp = os.date("%Y%m%d%H%M%S")
        local filename = snippets_dir .. "/" .. timestamp .. "-" .. title .. ".md"
        
        -- Write file
        vim.fn.writefile(content, filename)
        
        vim.notify("Snippet saved to: " .. filename, vim.log.levels.INFO)
      end, { range = true })
    end,
    keys = {
      -- All Obsidian commands under <leader>o*
      -- Global commands (work from anywhere)
      { "<leader>o", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
      
      -- Markdown-only commands
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New Note", ft = "markdown" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today", ft = "markdown" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian Yesterday", ft = "markdown" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian Backlinks", ft = "markdown" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Obsidian Links", ft = "markdown" },
      { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Obsidian Toggle Checkbox", ft = "markdown" },
      { "<leader>oa", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open in App", ft = "markdown" },
      { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template", ft = "markdown" },
      { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian Follow Link", ft = "markdown" },
      
      -- Custom snippet capture
      { "<leader>oy", "<cmd>ObsidianYankSnippet<cr>", desc = "Obsidian Yank Snippet", mode = "v" },
    },
  },
}

