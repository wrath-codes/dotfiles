local M = {}

function M.setup()
  -- Custom function: Yank selection to Obsidian snippet using template
  vim.api.nvim_create_user_command("ObsidianYankSnippet", function(opts)
    -- Get visual selection using range from command
    local bufnr = vim.api.nvim_get_current_buf()
    local start_line = opts.line1
    local end_line = opts.line2
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

    if #lines == 0 then
      vim.notify("No selection", vim.log.levels.WARN)
      return
    end

    -- Get current filetype for language tag
    local ft = vim.bo.filetype
    local lang = ft ~= "" and ft or "text"

    -- Get first line as default title suggestion
    local first_line = lines[1]:gsub("^%s*(.-)%s*$", "%1")
    first_line = first_line:gsub("^#+%s*", "")

    -- Prompt for title using nui.nvim
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local input = Input({
      position = "50%",
      size = {
        width = 60,
      },
      border = {
        style = "rounded",
        text = {
          top = " Snippet Title ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "> ",
      default_value = first_line,
      on_close = function()
        vim.notify("Snippet cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(title)
        if not title or title == "" then
          vim.notify("No title provided", vim.log.levels.WARN)
          return
        end

        -- Create file in snippets directory
        local snippets_dir = vim.fn.expand("~/obsd/second-brain/snippets")
        vim.fn.mkdir(snippets_dir, "p")

        local timestamp_id = os.date("%Y%m%d%H%M%S")
        local filename_slug = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
        local filename = snippets_dir .. "/" .. filename_slug .. ".md"
        local today = os.date("%Y-%m-%d")
        local time = os.date("%H:%M:%S")
        local datetime = today .. " " .. time

        -- Create content with frontmatter (as a list of lines)
        local content = {
          "---",
          "id: " .. timestamp_id .. "-" .. filename_slug,
          "created_date: " .. today,
          "created_time: " .. time,
          "created_datetime: " .. datetime,
          "updated_date: " .. today,
          "type: reference-snippet",
          "tags:",
          "  - snippet",
          "  - " .. lang,
          "lang: " .. lang,
          "---",
          "",
          "# " .. title,
          "",
          "```" .. lang,
        }

        -- Add each line of code individually
        for _, line in ipairs(lines) do
          table.insert(content, line)
        end

        -- Close code block
        table.insert(content, "```")
        table.insert(content, "")

        -- Write file
        vim.fn.writefile(content, filename)

        vim.notify("Snippet saved to: " .. filename, vim.log.levels.INFO)
      end,
    })

    input:mount()

    -- Auto-close on escape
    input:map("n", "<Esc>", function()
      input:unmount()
    end, { noremap = true })
  end, { range = true })

  -- Search all notes
  vim.api.nvim_create_user_command("ObsidianSearchAll", function()
    require("snacks").picker.grep({
      cwd = vim.fn.expand("~/obsd/second-brain"),
      title = " Obsidian Search All ",
    })
  end, {
    desc = "Search all Obsidian notes",
  })

  -- Search snippets
  vim.api.nvim_create_user_command("ObsidianSearchSnippets", function()
    local snippets_dir = vim.fn.expand("~/obsd/second-brain/snippets")
    local items = {}

    -- Scan for .md files
    local files = vim.fn.glob(snippets_dir .. "/*.md", false, true)
    for _, file in ipairs(files) do
      local content = vim.fn.readfile(file)
      local title = ""
      local code_blocks = {}

      for i, line in ipairs(content) do
        if line:match("^# ") and title == "" then
          title = line:gsub("^# ", "")
        elseif line:match("^```") then
          local lang = line:gsub("^```", "")
          local code_start = i + 1
          local code_end = code_start
          while code_end <= #content and not content[code_end]:match("^```") do
            code_end = code_end + 1
          end
          if code_end <= #content then
            local code = table.concat(content, "\n", code_start, code_end - 1)
            table.insert(code_blocks, { lang = lang, code = code })
          end
        end
      end

      for _, block in ipairs(code_blocks) do
        table.insert(items, {
          text = title .. " (" .. block.lang .. ")",
          file = file,
          code = block.code,
          lang = block.lang,
          title = title,
        })
      end
    end

    require("snacks").picker({
      items = items,
      title = " Obsidian Snippets ",
      format = function(item)
        return { { item.text } }
      end,
      preview = function(ctx)
        ctx.preview:set_lines(vim.split(ctx.item.code, "\n"))
        ctx.preview:highlight({ ft = ctx.item.lang })
      end,
      confirm = function(picker, item)
        picker:close()
        -- Paste the code
        vim.api.nvim_put(vim.split(item.code, "\n"), "c", true, true)
        vim.notify("Snippet pasted: " .. item.title, vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Search Obsidian snippets",
  })
end

return M
