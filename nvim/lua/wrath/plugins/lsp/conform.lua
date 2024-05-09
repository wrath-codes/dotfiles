local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      svelte = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      python = { "isort", "black" },
      json = { { "prettierd", "prettier" } },
      graphql = { { "prettierd", "prettier" } },
      java = { "google-java-format" },
      kotlin = { "ktlint" },
      ruby = { "standardrb" },
      markdown = { { "prettierd", "prettier" } },
      erb = { "htmlbeautifier" },
      html = { "htmlbeautifier" },
      bash = { "beautysh" },
      proto = { "buf" },
      rust = { "rustfmt" },
      yaml = { "yamlfix" },
      toml = { "taplo" },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      sh = { { "shellcheck" } },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    },
  })
end

return M
