local M = {}

local health = vim.health or require("health")
local start = health.start or health.report_start
local ok = health.ok or health.report_ok
local warn = health.warn or health.report_warn
local error = health.error or health.report_error
local info = health.info or health.report_info

function M.check()
  start("amp-extras.nvim")

  local config = require("amp-extras.config").get()
  
  ok("Configuration loaded")
  info("Picker: " .. config.picker)
  info("Data directory: " .. config.data_dir)

  start("Dependencies")
  
  if pcall(require, "amp") then
    ok("amp.nvim is installed")
  else
    error("amp.nvim is not installed", {
      "Install with: https://github.com/sourcegraph/amp.nvim",
    })
  end
  
  if config.picker == "snacks" then
    if pcall(require, "snacks") then
      ok("snacks.nvim is installed (configured picker)")
    else
      error("snacks.nvim is not installed but configured as picker", {
        "Install with: https://github.com/folke/snacks.nvim",
        "Or change picker to 'telescope' in config",
      })
    end
  elseif config.picker == "telescope" then
    if pcall(require, "telescope") then
      ok("telescope.nvim is installed (configured picker)")
    else
      error("telescope.nvim is not installed but configured as picker", {
        "Install with: https://github.com/nvim-telescope/telescope.nvim",
        "Or change picker to 'snacks' in config",
      })
    end
  end
  
  if pcall(require, "nui.input") then
    ok("nui.nvim is installed (optional, enhances input)")
  else
    warn("nui.nvim is not installed", {
      "Input will fall back to vim.ui.input",
      "For better UX, install: https://github.com/MunifTanjim/nui.nvim",
    })
  end

  start("Data Directory")
  
  local data_dir = config.data_dir
  local stat = vim.loop.fs_stat(data_dir)
  
  if stat then
    ok("Data directory exists: " .. data_dir)
    
    local prompts_file = data_dir .. "/prompts.json"
    if vim.fn.filereadable(prompts_file) == 1 then
      ok("Prompts file exists")
      
      local content = table.concat(vim.fn.readfile(prompts_file), "\n")
      local success, data = pcall(vim.json.decode, content)
      
      if success and data then
        local num_prompts = #(data.prompts or {})
        local num_categories = #(data.categories or {})
        info("Prompts: " .. num_prompts .. ", Categories: " .. num_categories)
      else
        warn("Prompts file exists but could not be parsed")
      end
    else
      warn("Prompts file does not exist yet", {
        "Will be created on first use",
      })
    end
  else
    warn("Data directory does not exist: " .. data_dir, {
      "Will be created when you run :lua require('amp-extras').setup()",
    })
  end

  start("Amp CLI")
  
  local cli = require("amp-extras.utils.cli")
  if cli.is_amp_installed() then
    ok("amp CLI is installed")
    
    cli.is_logged_in(function(logged_in)
      if logged_in then
        vim.schedule(function()
          info("Logged in to Amp")
        end)
      else
        vim.schedule(function()
          warn("Not logged in to Amp", {
            "Run :AmpLogin to authenticate",
          })
        end)
      end
    end)
  else
    error("amp CLI is not installed or not in PATH", {
      "Install from: https://docs.sourcegraph.com/cli",
    })
  end

  start("Commands")
  
  local commands_count = 0
  for name, _ in pairs(vim.api.nvim_get_commands({})) do
    if name:match("^Amp") then
      commands_count = commands_count + 1
    end
  end
  
  if commands_count > 0 then
    ok(commands_count .. " Amp commands registered")
  else
    warn("No Amp commands registered", {
      "Make sure you've called require('amp-extras').setup()",
    })
  end
end

return M
