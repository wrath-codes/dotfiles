local M = {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      }
    },
}

M.get_harpoons = function()
 local harpoon_list = require("harpoom").list()
  return harpoon_list
end

return M
