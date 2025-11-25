local M = {}

function M.setup()
  return {
    "filename",
    file_status = true,
    newfile_status = true,
    path = 4,
    separator = { left = "", right = "" },
    shorting_target = 20,
    symbols = {
      modified = "[+]",
      readonly = "[-]",
      unnamed = "[No Name]",
      newfile = "[New]",
    },
  }
end

return M
