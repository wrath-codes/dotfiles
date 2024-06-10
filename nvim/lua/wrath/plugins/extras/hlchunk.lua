local M = {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
}

function M.config()
    require("hlchunk").setup({})
end

return M
-- {
-- },
