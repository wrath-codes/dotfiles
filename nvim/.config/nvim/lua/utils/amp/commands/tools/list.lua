local M = {}
local cli = require("utils.amp.utils.cli")

-- Cache for Amp tool details
M.tools_cache = {}
M.tools_list_hash = nil

--- Fetch full details for a tool
---@param tool_name string The name of the tool to fetch details for
---@param callback fun(data: table) Callback function called with tool data when fetched
function M.fetch_tool_details(tool_name, callback)
  cli.run_json_command("tools show --json " .. vim.fn.shellescape(tool_name), function(data)
    if data then
      M.tools_cache[tool_name] = data
      callback(data)
    end
  end)
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

function M.setup()
  -- List available Amp tools with snacks picker
  vim.api.nvim_create_user_command("AmpToolsList", function()
    cli.run_command("tools list", function(lines)
      -- Parse the output into picker items
      local items = {}
      local longest_name = 0
      local tool_names = {}

      for i, line in ipairs(lines) do
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
        -- layout = {
        -- },
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
    end)
  end, {
    desc = "List available Amp tools",
  })
end

return M
