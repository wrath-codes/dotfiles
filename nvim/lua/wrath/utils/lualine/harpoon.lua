local utils = require("wrath.utils.misc")
local harpoon = utils.lazy_require("harpoon")
local lualine_require = require("lualine_require")

local modules = lualine_require.lazy_require({
  default_config = "lualine.components.diagnostics.config",
  sources = "lualine.components.diagnostics.sources",
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
  utils_notices = "lualine.utils.notices",
})

harpoon.setup({
  global_settings = {
    save_on_toggle = true,
    save_on_change = true,
  },
  projects = {
    [utils.get_full_path(vim.fn.stdpath("config"), "lua")] = {
      term = {
        cmds = {
          "echo 'Hello, World!'",
        },
      },
    },
  },
})

local colors = {
  aged_plastic_yellow = "#fffbe8",
  code_green = "#c8ffa7",
  code_pink = "#ffaff3",
}

local M = require("lualine.component"):extend()
local highlight = require("lualine.highlight")

function M:init(options)
  M.super.init(self, options)
  self.status_symbols = {
    set = "",
    unset = "",
    current = "󰞁",
  }

  self.colors = {
    set = highlight.create_component_highlight_group({ fg = colors.aged_plastic_yellow }, "mark_set", self.options),

    unset = highlight.create_component_highlight_group({ fg = colors.code_pink }, "mark_unset", self.options),

    current = highlight.create_component_highlight_group({ fg = colors.code_green }, "mark_current", self.options),
  }
end

function M:update_status()
  local mark = { -- fetch actual mark
    clean = "",
    unclean = "",
    current = "",
  }
  local pieces = {}
  for _, status in ipairs({ "clean", "unclean" }) do
    local num = mark[status]
    if num > 0 then
      table.insert(
        pieces,
        string.format(
          "%s%s%s",
          highlight.component_format_highlight(self.colors[status]),
          self.status_symbols[status],
          num
        )
      )
    end
  end
  return table.concat(pieces, " ")
end

return M
