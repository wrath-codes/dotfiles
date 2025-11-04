local M = {}

local picker = require("amp-extras.core.picker")
local utils = require("amp-extras.core.utils")

M.threads_cache = {}

---Sanitize thread title into a safe filename
---@param title string
---@return string
local function sanitize_filename(title)
  local safe = title:gsub("[^%w%s%-]", ""):gsub("[%s%-]+", "_")
  safe = safe:gsub("^_+", ""):gsub("_+$", ""):sub(1, 50)
  return safe .. ".md"
end

---Fetch markdown content for a thread
---@param thread_id string
---@param callback function
function M.fetch_thread_markdown(thread_id, callback)
  local cli = require("amp-extras.utils.cli")
  cli.run_command("threads markdown " .. vim.fn.shellescape(thread_id), function(lines)
    local content = table.concat(lines, "\n")
    M.threads_cache[thread_id] = content
    callback(content)
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("AmpThreadsList", function()
    local cli = require("amp-extras.utils.cli")
    
    cli.run_command("threads list", function(lines)
      local items = {}
      local longest_title = 0

      for i = 3, #lines do
        local line = lines[i]
        if line and line ~= "" then
          local last_space_t = line:find(" T%-")
          if last_space_t then
            local title = line:sub(1, last_space_t - 1):gsub("%s+$", "")
            local thread_id = line:sub(last_space_t + 1)
            if title == "" then
              title = "Untitled"
            end
            longest_title = math.max(longest_title, #title)
            table.insert(items, {
              text = title,
              thread_id = thread_id,
              title = title,
            })
          end
        end
      end

      if #items == 0 then
        vim.notify("No threads found", vim.log.levels.WARN)
        return
      end

      local hints = {
        " <C-S-c>  copy raw markdown to clipboard",
        " <C-S-s>  save thread to .md file",
        " <CR>     copy thread ID to clipboard",
        " ?        toggle help",
      }

      picker.show({
        items = items,
        title = " Threads ",
        layout = picker.create_layout(),
        actions = {
          ["<C-S-c>"] = function(p, item)
            if not item then
              vim.notify("No item selected", vim.log.levels.WARN)
              return
            end
            
            local raw = M.threads_cache[item.thread_id]
            if raw then
              utils.copy_to_clipboard(raw)
              vim.notify("Copied raw thread markdown", vim.log.levels.INFO)
            else
              vim.notify("Fetching thread content...", vim.log.levels.INFO)
              M.fetch_thread_markdown(item.thread_id, function(content)
                utils.copy_to_clipboard(content)
                vim.notify("Copied raw thread markdown", vim.log.levels.INFO)
              end)
            end
          end,
          ["<C-S-s>"] = function(p, item)
            if not item then
              vim.notify("No item selected", vim.log.levels.WARN)
              return
            end
            
            local function save_thread(raw)
              local dir = vim.fn.expand("~/amp/saved_threads/")
              vim.fn.mkdir(dir, "p")
              local filename = sanitize_filename(item.title)
              local filepath = dir .. filename
              vim.fn.writefile(vim.split(raw, "\n"), filepath)
              vim.notify("Saved thread to '" .. filepath .. "'", vim.log.levels.INFO)
              vim.cmd.edit(filepath)
            end
            
            local raw = M.threads_cache[item.thread_id]
            if raw then
              save_thread(raw)
            else
              vim.notify("Fetching thread content...", vim.log.levels.INFO)
              M.fetch_thread_markdown(item.thread_id, function(content)
                save_thread(content)
              end)
            end
          end,
        },
        format = function(item)
          return { { item.text, "SnacksPickerLabel" } }
        end,
        preview = function(ctx)
          local item = ctx.item
          if not item or not item.thread_id then
            return
          end

          local lines = {
            "# " .. item.title,
            "",
            "Thread ID: " .. item.thread_id,
          }

          if M.threads_cache[item.thread_id] then
            local markdown_lines = vim.split(M.threads_cache[item.thread_id], "\n")
            lines = { "# " .. item.title, "", "Thread ID: " .. item.thread_id, "" }
            vim.list_extend(lines, markdown_lines)
          else
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

          ctx.preview:reset()
          ctx.preview:set_lines(lines)
          ctx.preview:highlight({ ft = "markdown" })
        end,
        confirm = function(p, item)
          p:close()
          utils.copy_to_clipboard(item.thread_id)
          vim.notify("Copied thread ID", vim.log.levels.INFO)
        end,
        on_show = function(p)
          picker.show_hints(p, hints)
        end,
        on_close = function(p)
          picker.close_hints(p)
        end,
      })
    end)
  end, {
    desc = "List available Amp threads",
  })
end

return M
