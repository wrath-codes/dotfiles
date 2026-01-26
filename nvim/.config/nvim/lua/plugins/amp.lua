if vim.g.vscode then return {} end

return {
  "sourcegraph/amp.nvim",
  branch = "main",
  enabled = true, -- Disabled to test amp-extras-rs
  lazy = false,
  opts = {
    auto_start = true,
    log_level = "info",
  },
}
