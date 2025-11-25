return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["q"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      watch_for_changes = true,
      float = {
        padding = 5,
        max_width = 0.4,
        max_height = 0.4,
        border = "rounded",
        win_options = {
          wrap = true,
          winblend = 0,
          winhl = "Normal:Normal,FloatBorder:DiagnosticInfo,FloatTitle:DiagnosticInfo",
        },
        preview_split = "above",
        override = function(conf)
          return conf
        end,
      },
      confirmation = {
        max_width = 0.4,
        min_width = 0.2,
        max_height = 0.2,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
    },
    keys = {
      { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
    },
  },
}
