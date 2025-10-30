local M = {}
local cli = require("utils.amp.utils.cli")

-- Cache for thread details (raw and formatted markdown content)
M.threads_cache = {}
M.threads_list_hash = nil

--- Format tool use JSON into readable markdown
---@param tool_name string
---@param data table
---@return string
local function format_tool_use(tool_name, data)
  if tool_name == "Read" and data.path then
    return "**Tool Use: Read**\n- Path: `" .. data.path .. "`"
  elseif tool_name == "Grep" and data.pattern then
    local parts = {}
    table.insert(parts, "**Tool Use: Grep**")
    table.insert(parts, "- Pattern: `" .. data.pattern .. "`")
    if data.path then
      table.insert(parts, "- Path: `" .. data.path .. "`")
    end
    if data.glob then
      table.insert(parts, "- Glob: `" .. data.glob .. "`")
    end
    return table.concat(parts, "\n")
  elseif tool_name == "run_terminal_cmd" or tool_name == "Bash" then
    return "**Tool Use: Run Command**\n- Command: `" .. (data.cmd or data.command or "unknown") .. "`"
  elseif tool_name == "edit_file" then
    return "**Tool Use: Edit File**\n- Path: `" .. (data.path or "unknown") .. "`"
  else
    -- Fallback: format key fields
    local parts = { "**Tool Use: " .. tool_name .. "**" }
    for k, v in pairs(data) do
      if type(v) == "string" then
        table.insert(parts, "- " .. k .. ": `" .. v .. "`")
      end
    end
    return table.concat(parts, "\n")
  end
end

--- Get language from file path
---@param path string
---@return string
local function get_language_from_path(path)
  local ext = path:match("%.(%w+)$")
  local lang_map = {
    lua = "lua",
    py = "python",
    js = "javascript",
    ts = "typescript",
    json = "json",
    md = "markdown",
    rs = "rust",
    go = "go",
    sh = "bash",
    yml = "yaml",
    yaml = "yaml",
    toml = "toml",
  }
  return lang_map[ext] or ""
end

--- Sanitize thread title into a safe filename
---@param title string
---@return string
local function sanitize_filename(title)
  -- Replace spaces and special characters with underscores
  local safe = title:gsub("[^%w%s%-]", ""):gsub("[%s%-]+", "_")
  -- Remove leading/trailing underscores and limit length
  safe = safe:gsub("^_+", ""):gsub("_+$", ""):sub(1, 50)
  return safe .. ".md"
end

--- Format tool result JSON into readable markdown
---@param tool_name string
---@param data table|string
---@return string
local function format_tool_result(tool_name, data)
  if type(data) == "string" then
    return "**Tool Result:**\n```\n" .. data .. "\n```"
  elseif type(data) == "table" then
    if data.output then
      -- Command output
      return "**Tool Result:**\n```\n" .. data.output .. "\n```"
    elseif tool_name == "Read" then
      if data.isDirectory then
        local items = {}
        for _, entry in ipairs(data.directoryEntries or {}) do
          table.insert(items, "- " .. entry)
        end
        return "**Tool Result:**\n" .. table.concat(items, "\n")
      else
        local lang = get_language_from_path(data.absolutePath or "")
        local lang_str = lang ~= "" and lang or ""
        return "**Tool Result:**\n```" .. lang_str .. "\n" .. (data.content or "") .. "\n```"
      end
    elseif tool_name == "Grep" then
      local results = {}
      for _, match in ipairs(data or {}) do
        table.insert(results, "- `" .. match.file .. "`:" .. match.line .. ": " .. match.content)
      end
      return "**Tool Result:**\n" .. table.concat(results, "\n")
    elseif tool_name == "glob" then
      -- Glob results, assume array of paths
      local results = {}
      for _, path in ipairs(data or {}) do
        table.insert(results, "- `" .. path .. "`")
      end
      return "**Tool Result:**\n" .. table.concat(results, "\n")
    else
      -- Pretty print JSON
      return "**Tool Result:**\n```json\n" .. vim.json.encode(data) .. "\n```"
    end
  else
    return "**Tool Result:** " .. tostring(data)
  end
end

--- Format JSON in markdown content for better readability
---@param content string The markdown content
---@return string The formatted content
local function format_markdown_content(content)
  -- Format **Tool Use:** sections
  content = content:gsub("%*%*Tool Use:%*%*%s*`([^`]+)`%s*```json\n(.-)\n```", function(tool_name, json_str)
    local ok, data = pcall(vim.json.decode, json_str)
    if ok and data then
      return format_tool_use(tool_name, data)
    else
      return "**Tool Use:** `" .. tool_name .. "`\n```json\n" .. json_str .. "\n```"
    end
  end)

  -- Format **Tool Result:** sections
  content = content:gsub("%*%*Tool Result:%*%*%s*`([^`]+)`%s*\n```\n(.-)\n```", function(tool_id, json_str)
    local ok, data = pcall(vim.json.decode, json_str)
    if ok and data then
      -- Try to infer tool name from context or use generic
      return format_tool_result("Read", data) -- Assume Read for now, could be smarter
    else
      return "**Tool Result:** `" .. tool_id .. "`\n```\n" .. json_str .. "\n```"
    end
  end)

  -- Format remaining ```json blocks
  content = content:gsub("```json\n(.-)\n```", function(json_str)
    local ok, data = pcall(vim.json.decode, json_str)
    if ok and data then
      return "```json\n" .. vim.json.encode(data) .. "\n```"
    else
      return "```json\n" .. json_str .. "\n```"
    end
  end)

  return content
end

--- Fetch markdown content for a thread
---@param thread_id string The thread ID to fetch markdown for
---@param callback fun(content: string) Callback with formatted markdown content
function M.fetch_thread_markdown(thread_id, callback)
  cli.run_command("threads markdown " .. vim.fn.shellescape(thread_id), function(lines)
    local raw_content = table.concat(lines, "\n")
    -- Format JSON in the content for better readability
    local formatted_content = format_markdown_content(raw_content)
    M.threads_cache[thread_id] = { raw = raw_content, formatted = formatted_content }
    callback(formatted_content)
  end)
end

function M.setup()
  -- List available Amp threads with snacks picker
  vim.api.nvim_create_user_command("AmpThreadsList", function()
    cli.run_command("threads list", function(lines)
      -- Parse the table output
      -- Skip header (line 1) and separator (line 2)
      local items = {}
       local longest_title = 0

      for i = 3, #lines do
      local line = lines[i]
      if line and line ~= "" then
      -- Find the last " T-" to extract thread_id
      local last_space_t = line:find(" T%-")
      if last_space_t then
      local title = line:sub(1, last_space_t - 1):gsub("%s+$", "") -- trim trailing spaces
      local thread_id = line:sub(last_space_t + 1)
      if title == "" then
        title = "Untitled"
      end
      longest_title = math.max(longest_title, #title)
      table.insert(items, {
      idx = #items + 1,
      score = #items + 1,
      text = title,
      thread_id = thread_id,
      title = title,
      description = thread_id,
      })
      end
      end
       end

       if #items == 0 then
         vim.notify("No threads found", vim.log.levels.WARN)
         return
      end

       longest_title = math.min(longest_title + 4, 40) -- Limit max width

       -- Show picker with dynamic preview
       local layout_config = {
         layout = {
         box = "horizontal",
       width = 0.8,
       min_width = 120,
       height = 0.8,
       {
         box = "vertical",
       border = true,
       title = "{title}",
       { win = "input", height = 1, border = "bottom" },
       { win = "list", border = "none" },
      },
       { win = "preview", width = 0.5, border = "rounded" },
      },
      }
       require("snacks").picker({
         items = items,
         title = " Threads",
        layout = layout_config,
        actions = {
          copy_raw = function(picker, item)
            local raw = M.threads_cache[item.thread_id] and M.threads_cache[item.thread_id].raw or ""
            vim.fn.setreg("+", raw)
            vim.notify("Copied raw thread markdown to clipboard", vim.log.levels.INFO)
          end,
          save_md = function(picker, item)
            local raw = M.threads_cache[item.thread_id] and M.threads_cache[item.thread_id].raw
            if not raw then
              vim.notify("Thread content not available", vim.log.levels.ERROR)
              return
            end
            local filename = sanitize_filename(item.title)
            vim.fn.writefile(vim.split(raw, "\n"), filename)
            vim.notify("Saved thread to '" .. filename .. "'", vim.log.levels.INFO)
            vim.cmd.edit(filename)
          end,
        },
        win = {
          input = {
            keys = {
              ["<C-S-r>"] = { "copy_raw", mode = { "i", "n" } },
              ["<C-S-s>"] = { "save_md", mode = { "i", "n" } },
              ["?"] = "toggle_help_input",
            },
          },
          list = {
            keys = {
              ["?"] = "toggle_help_list",
            },
          },
        },
        on_show = function(picker)
          if not picker.hints_win or not vim.api.nvim_win_is_valid(picker.hints_win) then
            local buf = vim.api.nvim_create_buf(false, true)
            local col_start = math.floor(0.1 * vim.o.columns)
            local width = math.floor(0.8 * vim.o.columns)
            local row = math.floor(0.9 * vim.o.lines)
            ---@diagnostic disable: inject-field
            picker.hints_win = vim.api.nvim_open_win(buf, false, {
              relative = "editor",
              width = width,
              height = 2,
              row = row,
              col = col_start,
              border = "rounded",
              style = "minimal",
              title = " Key Hints ",
            })
            local hints = {
              " <C-S-r>  copy raw markdown to clipboard",
              " <C-S-s>  save thread to .md file",
              " <CR>     copy thread ID to clipboard",
              " ?        toggle help",
            }
            local hint_lines = {}
            for i = 1, #hints, 2 do
              local line = hints[i]
              if hints[i + 1] then
                line = line .. string.rep(" ", 55 - #hints[i]) .. hints[i + 1]
              end
              table.insert(hint_lines, line)
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, hint_lines)
            -- Highlight keymaps and descriptions
            local ns = vim.api.nvim_create_namespace("amp_hints")
            vim.hl.range(buf, ns, "SnacksPickerLabel", {0, 0}, {0, 10})
            vim.hl.range(buf, ns, "Comment", {0, 10}, {0, 55})
            vim.hl.range(buf, ns, "SnacksPickerLabel", {0, 55}, {0, 65})
            vim.hl.range(buf, ns, "Comment", {0, 65}, {0, -1})
            vim.hl.range(buf, ns, "SnacksPickerLabel", {1, 0}, {1, 9})
            vim.hl.range(buf, ns, "Comment", {1, 9}, {1, 55})
            vim.hl.range(buf, ns, "SnacksPickerLabel", {1, 55}, {1, 64})
            vim.hl.range(buf, ns, "Comment", {1, 64}, {1, -1})
          end
        end,
        on_close = function(picker)
          ---@diagnostic disable: undefined-field
          if picker.hints_win and vim.api.nvim_win_is_valid(picker.hints_win) then
            vim.api.nvim_win_close(picker.hints_win, true)
          end
        end,

        preview = function(ctx)
          local item = ctx.item

          if not item or not item.thread_id then
            return
          end

          -- Build preview lines
          local lines = {
            "# " .. item.title,
            "",
            "Thread ID: " .. item.thread_id,
          }

          -- Check cache and use formatted markdown if available
          if M.threads_cache[item.thread_id] then
            local markdown_lines = vim.split(M.threads_cache[item.thread_id].formatted, "\n")
            lines = { "# " .. item.title, "", "Thread ID: " .. item.thread_id, "" }
            vim.list_extend(lines, markdown_lines)
          else
            -- Fetch markdown in background
            M.fetch_thread_markdown(item.thread_id, function(content)
              if ctx.item and ctx.item.thread_id == item.thread_id then
                local markdown_lines = vim.split(content, "\n")
                lines = { "# " .. item.title, "", "Thread ID: " .. item.thread_id, "" }
                vim.list_extend(lines, markdown_lines)
                ctx.preview:reset()
                ctx.preview:set_lines(lines)
                ctx.preview:highlight({ ft = "markdown" })
              end
            end)
          end

          -- Return preview content
          ctx.preview:reset()
          ctx.preview:set_lines(lines)
          ctx.preview:highlight({ ft = "markdown" })
        end,
        format = function(item)
          local ret = {}
          ret[#ret + 1] = { string.format("%-" .. longest_title .. "s", item.title), "SnacksPickerLabel" }
          return ret
        end,
        confirm = function(picker, item)
          picker:close()
          vim.fn.setreg("+", item.thread_id)
          vim.notify("Copied '" .. item.thread_id .. "' to clipboard", vim.log.levels.INFO)
        end,
      })
    end)
  end, {
    desc = "List available Amp threads",
  })
end

return M