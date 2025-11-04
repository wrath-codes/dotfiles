if vim.g.loaded_amp_extras then
  return
end
vim.g.loaded_amp_extras = 1

vim.api.nvim_create_user_command("AmpExtrasSetup", function()
  require("amp-extras").setup()
end, { desc = "Setup amp-extras plugin" })
