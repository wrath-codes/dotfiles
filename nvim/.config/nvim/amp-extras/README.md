# amp-extras.nvim

Enhanced utilities and commands for [amp.nvim](https://github.com/sourcegraph/amp.nvim) - a powerful plugin consolidating 35 Amp commands with unified abstractions.

## ✨ Features

- **🎯 Dash X Prompts** - Manage and execute custom prompts with categories
- **📡 MCP Commands** - Full Model Context Protocol server management
- **🔐 Permissions** - Edit, list, test, and add Amp permissions
- **📤 Send Commands** - Send messages, buffers, selections, and file references
- **🚀 Session Management** - Quick session creation and execution
- **👤 Account Management** - Login, logout, and update commands
- **🔌 35 Commands** with `<Plug>` mappings for customization
- **📦 772 Lines Removed** through abstraction reuse (vs original implementation)

## 📋 Requirements

**Required:**
- Neovim >= 0.9.0
- [amp.nvim](https://github.com/sourcegraph/amp.nvim)
- [snacks.nvim](https://github.com/folke/snacks.nvim) OR [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- Amp CLI installed and in PATH

**Optional:**
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - Enhanced input dialogs (recommended)
- [which-key.nvim](https://github.com/folke/which-key.nvim) - For keymap hints

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim) with snacks.nvim

```lua
{
  "amp-extras",
  dir = "~/.config/nvim/amp-extras",
  dependencies = {
    "sourcegraph/amp.nvim",
    "folke/snacks.nvim",
    "MunifTanjim/nui.nvim", -- optional but recommended
  },
  opts = {
    picker = "snacks",
    data_dir = vim.fn.expand("~/.config/amp-extras"),
  },
  config = function(_, opts)
    require("amp-extras").setup(opts)
  end,
}
```

### Using lazy.nvim with telescope.nvim

```lua
{
  "amp-extras",
  dir = "~/.config/nvim/amp-extras",
  dependencies = {
    "sourcegraph/amp.nvim",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim", -- optional but recommended
  },
  opts = {
    picker = "telescope",
    data_dir = vim.fn.expand("~/.config/amp-extras"),
  },
  config = function(_, opts)
    require("amp-extras").setup(opts)
  end,
}
```

## ⚙️ Configuration

### Default Configuration

```lua
require("amp-extras").setup({
  -- Picker backend: "snacks" or "telescope"
  picker = "snacks",
  
  -- Directory for storing user data (prompts, categories)
  data_dir = vim.fn.expand("~/.config/amp-extras"),
  
  -- Keymaps configuration
  keymaps = {
    enabled = true,
  },
})
```

### Custom Configuration Example

```lua
require("amp-extras").setup({
  picker = "telescope",
  data_dir = vim.fn.expand("~/my-amp-data"),
  keymaps = {
    enabled = false, -- Disable default keymaps, use <Plug> mappings instead
  },
})
```

## 📚 Commands

### Dash X (Prompts)

| Command | Description |
|---------|-------------|
| `:AmpDashX` | List and execute saved prompts |
| `:AmpDashXAdd` | Add a new prompt |
| `:AmpDashXManage` | Manage existing prompts |
| `:AmpDashXCategories` | Manage prompt categories |
| `:AmpSessionExecute` | Quick execute (save to Uncategorized) |

### Send Commands

| Command | Description |
|---------|-------------|
| `:AmpSend` | Send a message to Amp |
| `:AmpSendBuffer` | Send current buffer to Amp |
| `:AmpPromptSelection` | Send visual selection to Amp |
| `:AmpPromptRef` | Send file reference with line numbers |
| `:AmpPromptFileRef` | Send file reference |

### Session Management

| Command | Description |
|---------|-------------|
| `:AmpSessionOpen` | Open new Amp interactive session |
| `:AmpSessionWithMessage` | Open session with initial message |

### MCP Commands

| Command | Description |
|---------|-------------|
| `:AmpMcpAddCommand` | Add MCP server with command |
| `:AmpMcpAddInteractive` | Add MCP server (interactive) |
| `:AmpMcpRemove` | Remove MCP server |
| `:AmpMcpOauth` | MCP OAuth management |
| `:AmpMcpDoctorAll` | Check all MCP server status |
| `:AmpMcpDoctorSingle` | Check single MCP server status |
| `:AmpMcpList` | List MCP servers |

### Permissions Commands

| Command | Description |
|---------|-------------|
| `:AmpPermissionsEdit` | Edit Amp permissions |
| `:AmpPermissionsList` | List Amp permissions |
| `:AmpPermissionsTest` | Test Amp permissions |
| `:AmpPermissionsAdd` | Add permission rule |

### Account Management

| Command | Description |
|---------|-------------|
| `:AmpLogin` | Log in to Amp |
| `:AmpLogout` | Log out from Amp |
| `:AmpUpdate` | Update Amp CLI |

## 🔌 Plug Mappings

All commands are available as `<Plug>` mappings for custom keybindings:

```lua
-- Example custom keymaps
vim.keymap.set("n", "<leader>ap", "<Plug>(AmpDashX)", { desc = "Amp Prompts" })
vim.keymap.set("n", "<leader>aa", "<Plug>(AmpDashXAdd)", { desc = "Add Prompt" })
vim.keymap.set("n", "<leader>am", "<Plug>(AmpSend)", { desc = "Send Message" })
vim.keymap.set("v", "<leader>as", "<Plug>(AmpPromptSelection)", { desc = "Send Selection" })
```

See `:help amp-extras-mappings` for the full list.

## 🎯 Default Prompts

The plugin ships with 5 default prompts:

1. **Security Review** (Code Review) - Review code for security vulnerabilities
2. **Extract Function** (Refactoring) - Suggest function extraction opportunities
3. **Generate Documentation** (Documentation) - Generate comprehensive documentation
4. **Add Debug Logging** (Debugging) - Add strategic debug logging
5. **Write Unit Tests** (Testing) - Generate comprehensive unit tests

## 💾 Data Storage

User data is stored in `~/.config/amp-extras/prompts.json` by default. The structure:

```json
{
  "version": "1.0.0",
  "categories": [...],
  "prompts": [...]
}
```

## 🏥 Health Check

Run `:checkhealth amp-extras` to verify:
- Dependencies are installed
- Amp CLI is available
- Data directory exists
- Configuration is valid
- Commands are registered

## 🚀 Quick Start

1. Install the plugin with your package manager
2. Run `:checkhealth amp-extras` to verify setup
3. Try `:AmpDashX` to see default prompts
4. Add your own with `:AmpDashXAdd`
5. Execute quickly with `<leader>adx` (if using default keymaps)

## 📖 Documentation

- `:help amp-extras` - Full documentation
- `:help amp-extras-commands` - All commands
- `:help amp-extras-config` - Configuration options
- `:help amp-extras-mappings` - Keybinding reference

## 🛠️ Development

### Project Structure

```
amp-extras/
├── plugin/
│   └── amp-extras.lua          # Global initialization
├── lua/amp-extras/
│   ├── init.lua                # Main entry point
│   ├── config.lua              # Configuration management
│   ├── health.lua              # Health checks
│   ├── core/                   # Core abstractions
│   │   ├── picker.lua          # Unified picker API
│   │   ├── terminal.lua        # Terminal execution
│   │   ├── input.lua           # Input handling
│   │   ├── markdown.lua        # Markdown rendering
│   │   └── utils.lua           # Shared utilities
│   ├── commands/               # Command modules
│   │   ├── init.lua            # Command registration
│   │   ├── prompts/            # Dash X commands
│   │   ├── send/               # Send commands
│   │   ├── session/            # Session commands
│   │   ├── account/            # Account commands
│   │   ├── mcp/                # MCP commands
│   │   └── permissions/        # Permission commands
│   ├── utils/                  # Utilities
│   │   ├── prompts.lua         # Prompts data management
│   │   └── cli.lua             # CLI utilities
│   └── data/
│       └── defaults.lua        # Default prompts/categories
├── doc/
│   └── amp-extras.txt          # Vim documentation
└── README.md                   # This file
```

## 🤝 Contributing

This is a personal plugin but suggestions and improvements are welcome!

## 📄 License

MIT

## 🙏 Credits

Built on top of [amp.nvim](https://github.com/sourcegraph/amp.nvim) by Sourcegraph.
