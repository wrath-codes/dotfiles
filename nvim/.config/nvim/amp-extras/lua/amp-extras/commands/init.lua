---@class AmpExtrasCommands
local M = {}

---Setup all command modules
function M.setup()
  require("amp-extras.commands.prompts.list").setup()
  require("amp-extras.commands.prompts.add").setup()
  require("amp-extras.commands.prompts.manage").setup()
  require("amp-extras.commands.prompts.categories").setup()

  require("amp-extras.commands.send.message").setup()
  require("amp-extras.commands.send.buffer").setup()
  require("amp-extras.commands.send.selection").setup()
  require("amp-extras.commands.send.ref").setup()
  require("amp-extras.commands.send.file_ref").setup()

  require("amp-extras.commands.session.open").setup()
  require("amp-extras.commands.session.with_message").setup()
  require("amp-extras.commands.session.execute").setup()

  require("amp-extras.commands.account.login").setup()
  require("amp-extras.commands.account.logout").setup()
  require("amp-extras.commands.account.update").setup()

  require("amp-extras.commands.mcp.add_command").setup()
  require("amp-extras.commands.mcp.add_interactive").setup()
  require("amp-extras.commands.mcp.remove").setup()
  require("amp-extras.commands.mcp.oauth").setup()
  require("amp-extras.commands.mcp.doctor_all").setup()
  require("amp-extras.commands.mcp.doctor_single").setup()
  require("amp-extras.commands.mcp.list").setup()

  require("amp-extras.commands.permissions.edit").setup()
  require("amp-extras.commands.permissions.list").setup()
  require("amp-extras.commands.permissions.test").setup()
  require("amp-extras.commands.permissions.add").setup()

  require("amp-extras.commands.threads.list").setup()
  require("amp-extras.commands.tools.list").setup()
end

---Register <Plug> mappings for all commands
function M.register_plug_mappings()
  vim.keymap.set("n", "<Plug>(AmpDashX)", "<cmd>AmpDashX<CR>", { desc = "List Amp prompts" })
  vim.keymap.set("n", "<Plug>(AmpDashXAdd)", "<cmd>AmpDashXAdd<CR>", { desc = "Add Amp prompt" })
  vim.keymap.set("n", "<Plug>(AmpDashXManage)", "<cmd>AmpDashXManage<CR>", { desc = "Manage Amp prompts" })
  vim.keymap.set("n", "<Plug>(AmpDashXCategories)", "<cmd>AmpDashXCategories<CR>", { desc = "Manage categories" })

  vim.keymap.set("n", "<Plug>(AmpSend)", "<cmd>AmpSend<CR>", { desc = "Send message to Amp" })
  vim.keymap.set("n", "<Plug>(AmpSendBuffer)", "<cmd>AmpSendBuffer<CR>", { desc = "Send buffer to Amp" })
  vim.keymap.set("v", "<Plug>(AmpPromptSelection)", "<cmd>AmpPromptSelection<CR>", { desc = "Send selection to Amp" })
  vim.keymap.set({ "n", "v" }, "<Plug>(AmpPromptRef)", "<cmd>AmpPromptRef<CR>", { desc = "Send file ref to Amp" })
  vim.keymap.set("n", "<Plug>(AmpPromptFileRef)", "<cmd>AmpPromptFileRef<CR>", { desc = "Send file ref to Amp" })

  vim.keymap.set("n", "<Plug>(AmpSessionOpen)", "<cmd>AmpSessionOpen<CR>", { desc = "Open Amp session" })
  vim.keymap.set(
    "n",
    "<Plug>(AmpSessionWithMessage)",
    "<cmd>AmpSessionWithMessage<CR>",
    { desc = "Amp session with message" }
  )
  vim.keymap.set("n", "<Plug>(AmpSessionExecute)", "<cmd>AmpSessionExecute<CR>", { desc = "Execute prompt" })

  vim.keymap.set("n", "<Plug>(AmpLogin)", "<cmd>AmpLogin<CR>", { desc = "Amp login" })
  vim.keymap.set("n", "<Plug>(AmpLogout)", "<cmd>AmpLogout<CR>", { desc = "Amp logout" })
  vim.keymap.set("n", "<Plug>(AmpUpdate)", "<cmd>AmpUpdate<CR>", { desc = "Update Amp" })

  vim.keymap.set("n", "<Plug>(AmpMcpAddCommand)", "<cmd>AmpMcpAddCommand<CR>", { desc = "Add MCP server (command)" })
  vim.keymap.set(
    "n",
    "<Plug>(AmpMcpAddInteractive)",
    "<cmd>AmpMcpAddInteractive<CR>",
    { desc = "Add MCP server (interactive)" }
  )
  vim.keymap.set("n", "<Plug>(AmpMcpRemove)", "<cmd>AmpMcpRemove<CR>", { desc = "Remove MCP server" })
  vim.keymap.set("n", "<Plug>(AmpMcpOauth)", "<cmd>AmpMcpOauth<CR>", { desc = "MCP OAuth" })
  vim.keymap.set("n", "<Plug>(AmpMcpDoctorAll)", "<cmd>AmpMcpDoctorAll<CR>", { desc = "MCP doctor all" })
  vim.keymap.set("n", "<Plug>(AmpMcpDoctorSingle)", "<cmd>AmpMcpDoctorSingle<CR>", { desc = "MCP doctor single" })
  vim.keymap.set("n", "<Plug>(AmpMcpList)", "<cmd>AmpMcpList<CR>", { desc = "List MCP servers" })

  vim.keymap.set("n", "<Plug>(AmpPermissionsEdit)", "<cmd>AmpPermissionsEdit<CR>", { desc = "Edit permissions" })
  vim.keymap.set("n", "<Plug>(AmpPermissionsList)", "<cmd>AmpPermissionsList<CR>", { desc = "List permissions" })
  vim.keymap.set("n", "<Plug>(AmpPermissionsTest)", "<cmd>AmpPermissionsTest<CR>", { desc = "Test permissions" })
  vim.keymap.set("n", "<Plug>(AmpPermissionsAdd)", "<cmd>AmpPermissionsAdd<CR>", { desc = "Add permission" })

  vim.keymap.set("n", "<Plug>(AmpThreadsList)", "<cmd>AmpThreadsList<CR>", { desc = "List threads" })
  vim.keymap.set("n", "<Plug>(AmpToolsList)", "<cmd>AmpToolsList<CR>", { desc = "List tools" })
end

return M
