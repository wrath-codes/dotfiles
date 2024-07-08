
local M = {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  event = "VeryLazy",
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}

function M.config()
  require("which-key").register({
    ['<leader>v']  {
      name = '+VenvSelector',
      s = { '<cmd>VenvSelector<cr>', 'Pick a virtual environment for the current project' },
      c = { 

}
    ['<leader>vs'] = { 'VenvSelector', 'Pick a virtual environment for the current project' },
    ['<leader>vc'] = { 'VenvSelectCached', 'Retrieve the venv from a cache' },
  })
  require("zen-mode").setup {
  }
end

return M

vim f
