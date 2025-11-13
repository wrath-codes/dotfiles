local M = {}

function M.setup()
  return {
    "filename",
    file_status = true,
    newfile_status = true,
    path = 1,
    shorting_target = 40,
    symbols = {
      modified = "[+]",
      readonly = "[-]",
      unnamed = "[No Name]",
      newfile = "[New]",
    },
  }
end

return M
