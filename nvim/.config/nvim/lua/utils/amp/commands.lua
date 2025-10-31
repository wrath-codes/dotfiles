local M = {}

function M.setup()
  -- Setup send commands
  require("utils.amp.commands.send.message").setup()
  require("utils.amp.commands.send.buffer").setup()
  require("utils.amp.commands.send.selection").setup()
  require("utils.amp.commands.send.ref").setup()

  -- Setup account commands
  require("utils.amp.commands.account.login").setup()
require("utils.amp.commands.account.logout").setup()
require("utils.amp.commands.account.update").setup()

  -- Setup tools and threads list commands
  require("utils.amp.commands.tools.list").setup()
  require("utils.amp.commands.threads.list").setup()

  -- Setup MCP commands
  require("utils.amp.commands.mcp.add_command").setup()
  require("utils.amp.commands.mcp.add_interactive").setup()
  require("utils.amp.commands.mcp.remove").setup()
  require("utils.amp.commands.mcp.oauth").setup()
  require("utils.amp.commands.mcp.doctor_all").setup()
  require("utils.amp.commands.mcp.doctor_single").setup()
  require("utils.amp.commands.mcp.list").setup()

  -- Setup prompts commands
  require("utils.amp.commands.prompts.list").setup()
  require("utils.amp.commands.prompts.add").setup()
  require("utils.amp.commands.prompts.manage").setup()
  require("utils.amp.commands.prompts.categories").setup()
end

return M