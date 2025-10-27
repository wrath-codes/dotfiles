return {
  {
    "benomahony/uv.nvim",
    ft = "python",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      require("uv").setup({
        auto_activate_venv = true,
        notify_activate_venv = true,
        auto_commands = true,
        picker_integration = true,
        
        -- Disable default keymaps (we'll set custom ones)
        keymaps = false,
      })
    end,
    keys = {
      -- All under <leader>v* for venv/Python management
      { "<leader>v", function() require("uv").show_commands() end, desc = "UV Commands Menu", ft = "python" },
      { "<leader>vr", "<cmd>UVRunFile<cr>", desc = "UV Run File", ft = "python" },
      { "<leader>vs", "<cmd>UVRunSelection<cr>", desc = "UV Run Selection", ft = "python", mode = "v" },
      { "<leader>vf", "<cmd>UVRunFunction<cr>", desc = "UV Run Function", ft = "python" },
      { "<leader>ve", function() require("uv").select_venv() end, desc = "UV Select Venv", ft = "python" },
      { "<leader>vi", "<cmd>UVInit<cr>", desc = "UV Init Project", ft = "python" },
      { "<leader>va", function() require("uv").add_package() end, desc = "UV Add Package", ft = "python" },
      { "<leader>vd", function() require("uv").remove_package() end, desc = "UV Remove Package", ft = "python" },
      { "<leader>vc", "<cmd>UVSync<cr>", desc = "UV Sync", ft = "python" },
    },
  },
}
