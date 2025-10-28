local M = {}

-- Cache for Amp tool details
M.tools_cache = {}
M.tools_list_hash = nil

--- Fetch full details for a tool
---@param tool_name string The name of the tool to fetch details for
---@param callback fun(data: table) Callback function called with tool data when fetched
function M.fetch_tool_details(tool_name, callback)
  vim.fn.jobstart("amp tools show --json " .. vim.fn.shellescape(tool_name), {
    on_stdout = function(_, data)
      if not data then
        return
      end
      local json_str = table.concat(data, "")
      if json_str == "" then
        return
      end

      local ok, tool_data = pcall(vim.json.decode, json_str)
      if ok and tool_data then
        M.tools_cache[tool_name] = tool_data
        callback(tool_data)
      else
      end
    end,
    on_stderr = function(_, data) end,
    stdout_buffered = true,
  })
end

--- Convert XML-style tags to markdown code blocks
---@param desc string The description string to format
---@return string The formatted description
function M.format_description(desc)
  -- Replace <examples>...</examples> sections
  desc = desc:gsub("<examples>", "**Examples:**")
  desc = desc:gsub("</examples>", "")

  -- Replace <example>...</example> with proper code blocks
  desc = desc:gsub("<example>\n", "```json\n")
  desc = desc:gsub("</example>", "```")

  -- Remove other XML-like tags
  desc = desc:gsub("<[^>]+>", "")

  return desc
end

--- Prefetch all tool details
---@param tool_names table Array of tool names to prefetch
function M.prefetch_all_tools(tool_names)
  for _, name in ipairs(tool_names) do
    if not M.tools_cache[name] then
      M.fetch_tool_details(name, function(data) end)
    end
  end
end

---@param cmd_opts table Command options containing args
function M.setup()
  -- Send a quick message to Amp
  vim.api.nvim_create_user_command("AmpSend", function(cmd_opts)
    ---@param cmd_opts table Command options containing args
    local message = cmd_opts.args
    if message == "" then
      print("Please provide a message to send")
      return
    end

    local amp_message = require("amp.message")
    amp_message.send_message(message)
  end, {
    nargs = "*",
    desc = "Send a message to Amp",
  })

  -- Send entire buffer contents
  vim.api.nvim_create_user_command("AmpSendBuffer", function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_message(content)
  end, {
    nargs = "?",
    desc = "Send current buffer contents to Amp",
  })

  -- Add selected text to prompt
  vim.api.nvim_create_user_command("AmpPromptSelection", function(cmd_opts)
    ---@param cmd_opts table Command options with line1 and line2
    local lines = vim.api.nvim_buf_get_lines(0, cmd_opts.line1 - 1, cmd_opts.line2, false)
    local text = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(text)
  end, {
    range = true,
    desc = "Add selected text to Amp prompt",
  })

  -- Add file+selection reference to prompt
  vim.api.nvim_create_user_command("AmpPromptRef", function(cmd_opts)
    ---@param cmd_opts table Command options with line1 and line2
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      print("Current buffer has no filename")
      return
    end

    local relative_path = vim.fn.fnamemodify(bufname, ":.")
    local ref = "@" .. relative_path
    if cmd_opts.line1 ~= cmd_opts.line2 then
      ref = ref .. "#L" .. cmd_opts.line1 .. "-" .. cmd_opts.line2
    elseif cmd_opts.line1 > 1 then
      ref = ref .. "#L" .. cmd_opts.line1
    end

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(ref)
  end, {
    range = true,
    desc = "Add file reference (with selection) to Amp prompt",
  })

  -- List available Amp tools with snacks picker
  vim.api.nvim_create_user_command("AmpToolsList", function()
    local output = {}

    vim.fn.jobstart("amp tools list", {
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(output, line)
            end
          end
        end
      end,
      on_exit = function()
        -- Parse the output into picker items
        local items = {}
        local longest_name = 0
        local tool_names = {}

        for i, line in ipairs(output) do
          -- Parse format: "tool_name    built-in Description text"
          local tool_name, description = line:match("^(%S+)%s+built%-in%s+(.+)$")
          if tool_name and description then
            longest_name = math.max(longest_name, #tool_name)
            table.insert(tool_names, tool_name)
            table.insert(items, {
              idx = i,
              score = i,
              text = tool_name .. " " .. description,
              tool_name = tool_name,
              description = description,
            })
          end
        end

        if #items == 0 then
          vim.notify("No tools found", vim.log.levels.WARN)
          return
        end

        -- Prefetch all tool details in background
        M.prefetch_all_tools(tool_names)

        longest_name = longest_name + 4

        -- Show picker with dynamic preview
        require("snacks").picker({
          items = items,
          title = " Amp Tools ",
          layout = {
            preview = true,
          },
          preview = function(ctx)
            -- Extract the actual item
            local item = ctx.item

            if not item or not item.tool_name or not item.description then
              return
            end

            -- Build preview lines
            local lines = {
              "# " .. item.tool_name,
              "",
              item.description,
            }

            -- Check cache and use full details if available
            if M.tools_cache[item.tool_name] and M.tools_cache[item.tool_name].description then
              local tool_data = M.tools_cache[item.tool_name]
              -- Format description to convert XML tags to markdown
              local formatted_desc = M.format_description(tool_data.description)
              local desc_lines = vim.split(formatted_desc, "\n")
              lines = { "# " .. tool_data.name, "" }
              vim.list_extend(lines, desc_lines)
            end

            -- Return preview content
            ctx.preview:reset()
            ctx.preview:set_lines(lines)
            ctx.preview:highlight({ ft = "markdown" })
          end,
          format = function(item)
            local ret = {}
            ret[#ret + 1] = { string.format("%-" .. longest_name .. "s", item.tool_name), "SnacksPickerLabel" }
            ret[#ret + 1] = { item.description, "SnacksPickerComment" }
            return ret
          end,
          confirm = function(picker, item)
            picker:close()
            vim.fn.setreg("+", item.tool_name)
            vim.notify("Copied '" .. item.tool_name .. "' to clipboard", vim.log.levels.INFO)
          end,
        })
      end,
      stdout_buffered = true,
    })
  end, {
    desc = "List available Amp tools",
  })
end

return M