---@class MarkdownPreviewOpts
---@field title string Item title
---@field category string|nil Category
---@field description string|nil Description
---@field prompt string|nil Prompt text
---@field additional table|nil Additional key-value pairs to render

local M = {}

---Render markdown preview for a prompt
---@param ctx table Preview context from picker
---@param item table Item to preview
---@param opts table|nil Additional options
function M.render_preview(ctx, item, opts)
  opts = opts or {}
  
  if not item then
    return
  end
  
  local lines = {}
  
  table.insert(lines, "# " .. (item.title or "Untitled"))
  table.insert(lines, "")
  
  if item.category then
    table.insert(lines, "**Category:** `" .. item.category .. "`")
  end
  
  if item.description then
    table.insert(lines, "**Description:** " .. item.description)
  end
  
  if opts.additional_fields then
    for _, field in ipairs(opts.additional_fields) do
      if item[field.key] then
        table.insert(lines, "**" .. field.label .. ":** " .. item[field.key])
      end
    end
  end
  
  if item.prompt then
    table.insert(lines, "")
    table.insert(lines, "**Prompt Text:**")
    table.insert(lines, "```")
    table.insert(lines, item.prompt)
    table.insert(lines, "```")
  end
  
  if opts.footer then
    table.insert(lines, "")
    table.insert(lines, "---")
    for _, line in ipairs(opts.footer) do
      table.insert(lines, line)
    end
  end
  
  ctx.preview:reset()
  ctx.preview:set_lines(lines)
  ctx.preview:highlight({ ft = "markdown" })
end

---Render markdown preview for a category
---@param ctx table Preview context from picker
---@param item table Category item to preview
---@param prompts table|nil List of prompts in category
function M.render_category_preview(ctx, item, prompts)
  if not item then
    return
  end
  
  local lines = {
    "# " .. item.name,
    "",
    "**Prompts:** " .. (item.prompt_count or 0),
  }
  
  if prompts and #prompts > 0 then
    table.insert(lines, "")
    table.insert(lines, "**Prompts in this category:**")
    for _, p in ipairs(prompts) do
      table.insert(lines, "- " .. p.title)
    end
  end
  
  ctx.preview:reset()
  ctx.preview:set_lines(lines)
  ctx.preview:highlight({ ft = "markdown" })
end

---Create footer lines for common actions
---@param actions table<string, string> Map of key to description
---@return string[] footer Footer lines
function M.create_footer(actions)
  local lines = {}
  
  for key, desc in pairs(actions) do
    table.insert(lines, "*Press `" .. key .. "` to " .. desc .. "*")
  end
  
  return lines
end

return M
