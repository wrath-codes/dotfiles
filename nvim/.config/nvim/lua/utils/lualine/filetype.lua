local M = {}

function M.setup()
  return {
    "filetype",
    colored = true,
    icon_only = true,
    icon = { align = "right", separator = "" },
    padding = { left = 1, right = 0 },
    separator = { left = "", right = "" },
    function()
      local filetype = vim.bo.filetype
      local upper_case_filetypes = {
        "json",
        "jsonc",
        "yaml",
        "toml",
        "css",
        "scss",
        "html",
        "xml",
        "xhtml",
      }

      if vim.tbl_contains(upper_case_filetypes, filetype) then
        return filetype:upper()
      end

      return filetype
    end,
  }
end

return M
