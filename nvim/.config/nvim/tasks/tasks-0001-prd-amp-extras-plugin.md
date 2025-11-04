# Task List: Amp Extras Plugin

## Relevant Files

### Core Abstractions (New)
- `lua/amp-extras/core/picker.lua` - Unified picker abstraction supporting snacks/telescope
- `lua/amp-extras/core/terminal.lua` - Centralized terminal execution utilities
- `lua/amp-extras/core/input.lua` - Input handling with NUI/fallback
- `lua/amp-extras/core/markdown.lua` - Markdown preview rendering utilities
- `lua/amp-extras/core/utils.lua` - Shared utility functions

### Plugin Infrastructure (New)
- `plugin/amp-extras.lua` - Global initialization script
- `lua/amp-extras/init.lua` - Main entry point with setup() function
- `lua/amp-extras/config.lua` - Configuration management and validation
- `lua/amp-extras/health.lua` - Health check integration
- `lua/amp-extras/data/defaults.lua` - Default prompts and categories
- `.luarc.json` - Lua language server configuration
- `doc/amp-extras.txt` - Vimdoc help documentation
- `README.md` - Installation and usage documentation

### Migrated Command Modules (Refactored from existing)
- `lua/amp-extras/commands/prompts/*.lua` - Dash X commands (4 files)
- `lua/amp-extras/commands/send/*.lua` - Send commands (5 files)
- `lua/amp-extras/commands/session/*.lua` - Session commands (3 files)
- `lua/amp-extras/commands/mcp/*.lua` - MCP commands (7 files)
- `lua/amp-extras/commands/permissions/*.lua` - Permission commands (4 files)
- `lua/amp-extras/commands/account/*.lua` - Account commands (4 files)
- `lua/amp-extras/commands/threads/*.lua` - Thread/tool listing (2 files)

### Data & Utils (Migrated)
- `lua/amp-extras/utils/prompts.lua` - Prompt data management utilities

### Notes

- All abstractions must support both snacks.nvim and telescope.nvim
- Each command file should be reduced by 50-70% in size by using abstractions
- Health check should validate all dependencies and report configuration
- Default prompts should ship with the plugin but user data stored separately in `~/.config/amp-extras/`

## Tasks

- [ ] 1.0 Create Plugin Infrastructure and Configuration System
  - [ ] 1.1 Create plugin directory structure: `lua/amp-extras/`, `plugin/`, `doc/`
  - [ ] 1.2 Create `plugin/amp-extras.lua` for minimal global initialization
  - [ ] 1.3 Create `lua/amp-extras/init.lua` with setup() function and default config
  - [ ] 1.4 Create `lua/amp-extras/config.lua` for configuration validation and merging
  - [ ] 1.5 Implement config validation using vim.validate for picker, data_dir, keymaps
  - [ ] 1.6 Create `~/.config/amp-extras/` data directory on first load
  - [ ] 1.7 Create `lua/amp-extras/data/defaults.lua` with 5 default prompts across categories
  - [ ] 1.8 Setup `.luarc.json` with Lua 5.1 runtime and type checking config
  - [ ] 1.9 Add LuaCATS annotations to config structures

- [ ] 2.0 Build Core Abstraction Layer (Picker, Terminal, Input, Markdown)
  - [ ] 2.1 Create `lua/amp-extras/core/picker.lua` with unified picker API
  - [ ] 2.2 Implement snacks.nvim picker backend in picker.lua
  - [ ] 2.3 Implement telescope.nvim picker backend in picker.lua (or defer to later)
  - [ ] 2.4 Create picker.create_layout() function for consistent layout config
  - [ ] 2.5 Create picker.show_hints() function for hints window with auto-highlighting
  - [ ] 2.6 Create picker.format_actions() helper for consistent action patterns
  - [ ] 2.7 Create `lua/amp-extras/core/terminal.lua` with terminal execution utilities
  - [ ] 2.8 Implement terminal.float_exec() for floating terminal with configurable size
  - [ ] 2.9 Implement terminal.wait_for_key() wrapper for "press key to close" pattern
  - [ ] 2.10 Create `lua/amp-extras/core/input.lua` for unified input handling
  - [ ] 2.11 Implement input.prompt() with NUI.nvim support (if available)
  - [ ] 2.12 Implement input.prompt() fallback to vim.ui.input when NUI missing
  - [ ] 2.13 Implement input.multi_step() for chained input flows
  - [ ] 2.14 Create `lua/amp-extras/core/markdown.lua` for preview rendering
  - [ ] 2.15 Implement markdown.render_preview() for consistent preview formatting
  - [ ] 2.16 Add LuaCATS annotations to all core module functions

- [ ] 3.0 Migrate and Refactor Prompts Commands (Dash X)
  - [ ] 3.1 Migrate `utils/prompts.lua` to `lua/amp-extras/utils/prompts.lua`
  - [ ] 3.2 Update prompts.lua to use `~/.config/amp-extras/` for data storage
  - [ ] 3.3 Refactor `prompts/list.lua` to use picker/terminal/markdown abstractions
  - [ ] 3.4 Refactor `prompts/add.lua` to use input abstraction for multi-step flow
  - [ ] 3.5 Refactor `prompts/manage.lua` to use picker abstraction and remove duplication
  - [ ] 3.6 Refactor `prompts/categories.lua` to use all core abstractions
  - [ ] 3.7 Create `<Plug>` mappings for all Dash X commands
  - [ ] 3.8 Verify all prompt commands work with refactored code
  - [ ] 3.9 Test picker with both snacks and telescope backends

- [ ] 4.0 Migrate and Refactor Send/Session/Account Commands
  - [ ] 4.1 Migrate all send commands (message, buffer, selection, ref, file_ref) to plugin
  - [ ] 4.2 Ensure amp.message integration works correctly
  - [ ] 4.3 Migrate session commands (open, with_message, execute) to plugin
  - [ ] 4.4 Refactor session/execute.lua to use input and terminal abstractions
  - [ ] 4.5 Refactor session/with_message.lua to use input abstraction
  - [ ] 4.6 Migrate account commands (login, logout, update) to plugin
  - [ ] 4.7 Refactor account/login.lua and logout.lua to use terminal abstraction
  - [ ] 4.8 Create `<Plug>` mappings for all send/session/account commands
  - [ ] 4.9 Verify all commands maintain exact same behavior

- [ ] 5.0 Migrate and Refactor MCP/Permissions/Threads Commands
  - [ ] 5.1 Migrate all MCP commands to plugin (7 files)
  - [ ] 5.2 Refactor MCP add commands to use input abstraction
  - [ ] 5.3 Refactor MCP list/doctor to use picker and terminal abstractions
  - [ ] 5.4 Migrate all permissions commands to plugin (4 files)
  - [ ] 5.5 Refactor permissions commands to use terminal abstraction
  - [ ] 5.6 Refactor permissions/add.lua to use input abstraction
  - [ ] 5.7 Migrate threads and tools listing commands
  - [ ] 5.8 Refactor threads/tools to use picker and markdown abstractions
  - [ ] 5.9 Create `<Plug>` mappings for all MCP/permissions/threads commands
  - [ ] 5.10 Verify all refactored commands work identically to originals

- [ ] 6.0 Documentation, Health Checks, and Testing
  - [ ] 6.1 Create `lua/amp-extras/health.lua` with dependency checks
  - [ ] 6.2 Add health checks for: amp.nvim, which-key, picker backend, NUI.nvim, data directory
  - [ ] 6.3 Write comprehensive README.md with installation instructions
  - [ ] 6.4 Document configuration options with examples for snacks and telescope
  - [ ] 6.5 Create vimdoc file `doc/amp-extras.txt` with all commands and API
  - [ ] 6.6 Document all `<Plug>` mappings with suggested default keybindings
  - [ ] 6.7 Add example lazy.nvim plugin specs for both picker backends
  - [ ] 6.8 Create migration guide from old structure to amp-extras
  - [ ] 6.9 Test all commands work without calling setup() (default behavior)
  - [ ] 6.10 Test all commands with custom configuration
  - [ ] 6.11 Run `:checkhealth amp-extras` and verify all checks pass
  - [ ] 6.12 Verify startup time impact is < 5ms (measure with --startuptime)

