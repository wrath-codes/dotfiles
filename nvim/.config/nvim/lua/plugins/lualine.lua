if vim.g.vscode then
  return {}
end

return {

  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local theme_config = require("utils.lualine.theme")
    local harpoon_component = require("utils.lualine.harpoon").setup()
    local filename_component = require("utils.lualine.filename").setup()
    local diagnostics_component = require("utils.lualine.diagnostics").setup()
    local diff_component = require("utils.lualine.diff").setup()
    local filetype_component = require("utils.lualine.filetype").setup()
    local amp_component = require("amp_extras.lualine").component()
    -- local amptab_component = require("amp_extras.amptab_v2.status").component()
    local date_component = require("utils.lualine.date").setup()
    local time_component = require("utils.lualine.time").setup()

    -- Apply custom theme colors and separators
    opts.theme = theme_config.modes()
    opts.section_separators = theme_config.separators.section_separators
    opts.component_separators = theme_config.separators.component_separators
    opts.inactive_sections = {}
    opts.winbar = {}

    -- Configure tabline (top bar) for harpoon
    opts.tabline = {
      lualine_c = {
        { "%=", separator = { left = "", right = "" }, right_padding = 0, left_padding = 0 },
        harpoon_component,
      },
    }

    -- Build on LazyVim's sections, keeping core components
    opts.sections = {
      lualine_a = {
        {
          "mode",
          icons_enabled = true,
          icon = "",
          separator = { left = "", right = theme_config.separators.section_separators.right },
          right_padding = 2,
        },
      },
      lualine_b = { { "branch", icon = "" } },
      lualine_c = {
        require("lazyvim.util").lualine.root_dir(),
        diagnostics_component,
        filename_component,
      },
      lualine_x = {

        filetype_component,
        diff_component,
      },
      lualine_y = {
        {
          "progress",
          separator = { left = theme_config.separators.section_separators.left, right = "" },
          padding = { left = 1, right = 0 },
        },
        {
          "location",
          padding = { left = 0, right = 1 },
          separator = { left = "", right = theme_config.separators.section_separators.right },
        },
        {
          "searchcount",
          separator = { left = "", right = theme_config.separators.component_separators.right },
          padding = { left = 0, right = 1 },
        },
        amp_component,
        -- amptab_component,
        {
          time_component,
          separator = {
            left = theme_config.separators.section_separators.left,
            right = theme_config.separators.section_separators.right,
          },
          right_padding = 0,
          left_padding = 0,
        },
      },
      lualine_z = { date_component },
    }

    opts.extensions = { "quickfix", "man", "oil", "lazy" }

    return opts
  end,
}
