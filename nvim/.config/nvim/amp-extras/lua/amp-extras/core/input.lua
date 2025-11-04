---@class InputOpts
---@field prompt string Prompt text
---@field default string|nil Default value
---@field title string|nil Window title (NUI only)
---@field width number|nil Width (NUI only)
---@field on_submit function|nil Callback on submit
---@field on_cancel function|nil Callback on cancel

---@class MultiStepOpts
---@field steps table[] Array of step configurations
---@field on_complete function Final callback with all results

local M = {}

---Check if NUI is available
---@return boolean available
local function has_nui()
  return pcall(require, "nui.input")
end

---Prompt for input using NUI
---@param opts InputOpts Input options
---@return boolean success
local function prompt_nui(opts)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event
  
  local input = Input({
    position = "50%",
    size = {
      width = opts.width or 60,
    },
    border = {
      style = "rounded",
      text = {
        top = opts.title and (" " .. opts.title .. " ") or " Input ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = opts.prompt .. " ",
    default_value = opts.default or "",
    on_close = function()
      if opts.on_cancel then
        opts.on_cancel()
      end
    end,
    on_submit = function(value)
      if opts.on_submit then
        opts.on_submit(value)
      end
    end,
  })
  
  input:mount()
  input:map("n", "<Esc>", function() input:unmount() end)
  input:map("n", "q", function() input:unmount() end)
  input:on(event.BufLeave, function() input:unmount() end)
  
  return true
end

---Prompt for input using vim.ui.input
---@param opts InputOpts Input options
---@return boolean success
local function prompt_fallback(opts)
  local vim_opts = {
    prompt = opts.prompt .. ": ",
    default = opts.default or "",
  }
  
  vim.ui.input(vim_opts, function(value)
    if value then
      if opts.on_submit then
        opts.on_submit(value)
      end
    else
      if opts.on_cancel then
        opts.on_cancel()
      end
    end
  end)
  
  return true
end

---Prompt for input with automatic backend selection
---@param opts InputOpts Input options
---@return boolean success
function M.prompt(opts)
  if not opts or not opts.prompt then
    vim.notify("amp-extras: Input prompt is required", vim.log.levels.ERROR)
    return false
  end
  
  if has_nui() then
    return prompt_nui(opts)
  else
    return prompt_fallback(opts)
  end
end

---Prompt for selection using vim.ui.select
---@param items string[] Items to select from
---@param opts table Options (prompt, format_item, etc.)
---@param on_choice function Callback with selected item
---@return boolean success
function M.select(items, opts, on_choice)
  vim.ui.select(items, opts, on_choice)
  return true
end

---Multi-step input flow
---@param opts MultiStepOpts Multi-step options
---@return boolean success
function M.multi_step(opts)
  if not opts or not opts.steps or #opts.steps == 0 then
    vim.notify("amp-extras: No steps provided for multi-step input", vim.log.levels.ERROR)
    return false
  end
  
  local results = {}
  local current_step = 1
  
  local function process_step()
    if current_step > #opts.steps then
      if opts.on_complete then
        opts.on_complete(results)
      end
      return
    end
    
    local step = opts.steps[current_step]
    
    if step.type == "input" then
      M.prompt({
        prompt = step.prompt,
        default = step.default,
        title = step.title,
        width = step.width,
        on_submit = function(value)
          results[step.key or current_step] = value
          current_step = current_step + 1
          vim.schedule(process_step)
        end,
        on_cancel = function()
          vim.notify("Multi-step input cancelled", vim.log.levels.INFO)
        end,
      })
    elseif step.type == "select" then
      M.select(step.items, {
        prompt = step.prompt,
      }, function(choice)
        if not choice then
          vim.notify("Multi-step input cancelled", vim.log.levels.INFO)
          return
        end
        
        results[step.key or current_step] = choice
        current_step = current_step + 1
        vim.schedule(process_step)
      end)
    end
  end
  
  process_step()
  return true
end

return M
