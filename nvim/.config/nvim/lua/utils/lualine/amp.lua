local M = {}

function M.setup()
  -- Define visual settings for Amp status with Catppuccin Mocha colors
  local catppuccin = require("catppuccin.palettes").get_palette("mocha")
  local amp_colors = {
    running = {
      icon = catppuccin.mauve, -- Green when running
      port = catppuccin.teal, -- Teal for port number
    },
    connected = {
      icon = catppuccin.green, -- Mauve when clients connected
      clients = catppuccin.peach, -- Peach for client count
    },
    stopped = {
      icon = catppuccin.overlay0, -- Dim gray when stopped
      text = catppuccin.mantle,
    },
    transparent = catppuccin.none,
  }

  -- Highlight groups for different Amp states
  vim.api.nvim_set_hl(0, "AmpRunning", { fg = amp_colors.running.icon, bg = amp_colors.transparent })
  vim.api.nvim_set_hl(0, "AmpPort", { fg = amp_colors.running.port, bg = amp_colors.transparent })
  vim.api.nvim_set_hl(0, "AmpConnected", { fg = amp_colors.connected.icon, bg = amp_colors.transparent })
  vim.api.nvim_set_hl(0, "AmpClients", { fg = amp_colors.connected.clients, bg = amp_colors.transparent })
  vim.api.nvim_set_hl(0, "AmpStopped", { fg = amp_colors.stopped.icon, bg = amp_colors.transparent })

  -- Auto-refresh lualine when Amp status changes
  -- Note: amp.nvim doesn't currently emit these events, but we keep them for future compatibility
  -- or if we decide to monkey-patch amp.nvim
  local augroup = vim.api.nvim_create_augroup("AmpStatusUpdate", { clear = true })

  -- Refresh lualine on Amp server/client events
  vim.api.nvim_create_autocmd("User", {
    pattern = { "AmpServerStarted", "AmpServerStopped", "AmpClientConnected", "AmpClientDisconnected" },
    callback = function()
      require("lualine").refresh()
    end,
    desc = "Refresh lualine on Amp events",
  })
  return M.component
end

M.component = function()
  local ok, amp = pcall(require, "amp")
  if not ok then
    return ""
  end

  -- Check state directly from amp.nvim module
  if not amp.state or not amp.state.server then
    -- Server stopped - show dim indicator
    return string.format("%%#AmpStopped# ● Amp")
  end

  -- Get detailed status from server module if available
  local client_count = 0
  local ok_server, server = pcall(require, "amp.server.init")
  if ok_server then
    local server_status = server.get_status()
    client_count = server_status.client_count or 0
  elseif amp.state.connected then
    client_count = 1 -- Fallback if we can't get exact count but know we are connected
  end

  local port = amp.state.port or 0

  if client_count > 0 then
    -- Connected - show active indicator with client count
    return string.format("%%#AmpConnected#● %%#AmpPort#Amp:%d %%#AmpClients#[%d]", port, client_count)
  else
    -- Running but no clients - show waiting indicator
    return string.format("%%#AmpRunning#○ %%#AmpPort#Amp:%d", port)
  end
end

return M
