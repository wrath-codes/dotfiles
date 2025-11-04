# PRD: Amp Extras - Enhanced Neovim Plugin

## Introduction/Overview

Transform the current Amp Neovim integration into a standalone, modular local plugin called "amp-extras". The current integration is tightly coupled to personal configuration with significant code duplication and lacks the modularity needed for proper maintenance. This plugin will provide a clean, well-structured foundation that extends amp.nvim with enhanced functionality while maintaining all current features without breaking existing workflows.

**Goal**: Create a maintainable, configurable local plugin that eliminates code duplication, supports multiple picker backends (snacks/telescope), and provides a solid foundation for potential future distribution.

## Goals

1. Eliminate code duplication across picker configurations, action patterns, terminal execution, and markdown parsing
2. Create a modular plugin structure with clear separation of concerns
3. Support both snacks.nvim and telescope.nvim as picker backends (user-configurable)
4. Maintain 100% compatibility with current functionality (zero breaking changes)
5. Implement proper data storage in `~/.config/amp-extras/` directory
6. Provide sensible defaults with 5 initial example prompts
7. Make NUI.nvim optional (recommended) with fallback to vim.ui.input
8. Establish clean plugin architecture for future enhancements

## User Stories

1. As a developer, I want to install amp-extras as a local plugin so that I can maintain it independently from my core Neovim config
2. As a user, I want to choose between snacks or telescope for pickers so that I can use my preferred UI framework
3. As a developer, I want all picker-related code centralized so that I don't repeat the same layout/hints/action patterns
4. As a user, I want my existing keybindings to work exactly as before so that my workflow isn't disrupted
5. As a new user, I want 5 example prompts included so that I understand how to use the prompt system
6. As a developer, I want clear abstractions for terminal execution so that I don't repeat the same floating terminal setup
7. As a user, I want my prompts stored in `~/.config/amp-extras/` so that my data is separate from the plugin code
8. As a developer, I want markdown parsing utilities centralized so that preview rendering is consistent
9. As a user without NUI.nvim, I want the plugin to still work using vim.ui.input so that dependencies are flexible

## Functional Requirements

### 1. Plugin Structure & Installation

1.1. Plugin must be installable as a local Neovim plugin named "amp-extras"
1.2. Plugin must live in the user's Neovim plugin configuration directory
1.3. Plugin must require amp.nvim (sourcegraph/amp.nvim) as a dependency
1.4. Plugin must require which-key as a dependency
1.5. Plugin must support either snacks.nvim OR telescope.nvim (user specifies in plugin spec)
1.6. Plugin must make NUI.nvim optional with clear fallback behavior

### 2. Configuration System

2.1. Plugin must accept configuration options during setup
2.2. Configuration must specify picker backend ("snacks" or "telescope")
2.3. Configuration must allow custom keybinding overrides
2.4. Configuration must allow custom data directory (default: `~/.config/amp-extras/`)
2.5. Configuration must support all current command groups (send, prompts, mcp, permissions, session, account, threads/tools)
2.6. Plugin must validate configuration and show helpful errors for missing required dependencies

### 3. Code Abstraction - Pickers

3.1. Plugin must provide unified picker abstraction layer supporting both snacks and telescope
3.2. Picker abstraction must handle: layout configuration, item formatting, preview rendering, actions, keybindings, hints window
3.3. All picker implementations (categories, prompts, manage, threads, tools, mcp) must use the unified abstraction
3.4. Hints window generation must be centralized with consistent styling
3.5. Picker refresh logic must be abstracted and reusable

### 4. Code Abstraction - Terminal Execution

4.1. Plugin must provide unified terminal execution utilities
4.2. Terminal utilities must support: floating terminals with configurable size, interactive terminals with "press key to close", command output capture
4.3. All commands using terminal execution must use the unified utilities
4.4. Terminal configuration (size, borders, titles) must be consistent and reusable

### 5. Code Abstraction - Forms & Inputs

5.1. Plugin must provide unified input handling (NUI.nvim or vim.ui.input fallback)
5.2. Input utilities must support: single inputs, multi-step input flows, input validation, cancellation handling
5.3. All commands using inputs (add prompt, add category, add permission, etc.) must use unified utilities

### 6. Code Abstraction - Markdown Parsing

6.1. Plugin must provide centralized markdown parsing utilities
6.2. Markdown utilities must handle preview rendering for pickers
6.3. Markdown utilities must support syntax highlighting
6.4. All preview functions must use unified markdown rendering

### 7. Data Management

7.1. Plugin must store user data in `~/.config/amp-extras/` directory
7.2. Plugin must create data directory on first run
7.3. Plugin must ship with 5 default example prompts across different categories
7.4. Plugin must support prompts.json format for storing prompts and categories
7.5. Plugin must preserve existing prompt management functionality (add, edit, delete, categorize)
7.6. Plugin must ensure user data is separate from plugin code

### 8. Feature Preservation

8.1. Plugin must preserve all Dash X functionality (prompt listing, management, categories, quick execute)
8.2. Plugin must preserve all Send functionality (message, buffer, selection, file ref, line ref)
8.3. Plugin must preserve all Session functionality (blank session, with message)
8.4. Plugin must preserve all MCP functionality (add, remove, list, doctor, oauth)
8.5. Plugin must preserve all Permissions functionality (edit, list, test, add)
8.6. Plugin must preserve all Account functionality (login, logout, update)
8.7. Plugin must preserve Threads and Tools listing

### 9. Default Keybindings

9.1. Plugin must provide default keybindings matching current setup
9.2. Default keybindings must use `<leader>a` as prefix
9.3. Keybinding groups: `as` (Send), `ad` (Dash X), `ax` (Session), `am` (MCP), `ap` (Permissions), `al` (Login), `at` (Threads/Tools)
9.4. Users must be able to override any keybinding in plugin configuration

### 10. Documentation

10.1. Plugin must include README with installation instructions
10.2. Plugin must document all configuration options
10.3. Plugin must document all available commands
10.4. Plugin must include examples for both snacks and telescope setup

## Non-Goals (Out of Scope)

1. Publishing to GitHub or public registries (keeping private/local for now)
2. Supporting pickers other than snacks and telescope (can be added later)
3. GUI-based configuration interface
4. Syncing prompts across machines
5. Importing prompts from external sources
6. Advanced prompt templating or variables
7. Integration with other editors besides Neovim
8. Web-based prompt management interface

## Design Considerations

### Plugin File Structure
```
amp-extras/                      # Plugin root
├── plugin/
│   └── amp-extras.lua          # Global initialization (minimal)
├── lua/
│   └── amp-extras/
│       ├── init.lua            # Main entry point with setup()
│       ├── config.lua          # Configuration & validation
│       ├── health.lua          # :checkhealth integration
│       ├── core/
│       │   ├── picker.lua      # Unified picker abstraction
│       │   ├── terminal.lua    # Terminal execution utilities
│       │   ├── input.lua       # Input handling (NUI/fallback)
│       │   ├── markdown.lua    # Markdown parsing/rendering
│       │   └── utils.lua       # Shared utilities
│       ├── commands/
│       │   ├── prompts/        # All Dash X commands
│       │   ├── send/           # Send commands
│       │   ├── session/        # Session management
│       │   ├── mcp/            # MCP commands
│       │   ├── permissions/    # Permissions commands
│       │   ├── account/        # Account management
│       │   └── threads/        # Threads/tools listing
│       └── data/
│           └── defaults.lua    # Default prompts/categories
├── doc/
│   └── amp-extras.txt          # Vimdoc help file
├── .luarc.json                 # lua-language-server config
├── .busted                     # Busted test config
└── README.md                   # Installation & usage
```

### Default Prompts (5 examples)
Should include variety to demonstrate features:
1. Code review prompt (Development category)
2. Bug investigation prompt (Development category)
3. Git commit message prompt (General category)
4. Documentation generation prompt (Documentation category)
5. Refactoring suggestion prompt (Development category)

### UI Consistency
- All pickers should have consistent layout (80% width, 80% height by default)
- All floating terminals should have consistent sizing patterns
- Hints windows should always use same styling and positioning
- Markdown previews should have consistent formatting

## Technical Considerations

### Plugin Development Best Practices

Following established Neovim plugin patterns (zignar.net, lumen-oss/nvim-best-practices):

**Structure & Organization:**
- Use `plugin/amp-extras.lua` for global initialization (minimal, runs at startup)
- Main logic in `lua/amp-extras/` for lazy loading
- Entry point: `lua/amp-extras/init.lua` with `setup()` function
- Sub-modules organized by feature domain
- Avoid "garbage dump" util modules - keep utilities scoped to their domain

**Initialization & Configuration:**
- DO NOT force `setup()` call - plugin should work with sensible defaults
- Configuration should be a separate concern from initialization
- Use `vim.tbl_deep_extend("force", defaults, user_config)` to merge configs
- Validate configuration using `vim.validate` (wrapped in pcall)
- Auto-initialize smartly when first command is used

**Lazy Loading:**
- Only load modules when their functionality is actually needed
- Use internal lazy loading - don't `require` all sub-modules in init.lua
- Consider metatable-based lazy loading for sub-modules
- Keep startup footprint minimal (< 5ms impact)

**Keymaps:**
- DO provide `<Plug>` mappings for all actions
- DON'T automatically create keymaps (let users define their own)
- DO provide default keymap suggestions in documentation
- Users can override via plugin spec or manual mapping

**Type Safety:**
- Use LuaCATS annotations (`---@type`, `---@param`, `---@return`) throughout
- Configure lua-language-server for type checking
- Annotate all public API functions
- Annotate configuration structures

**Versioning:**
- Use SemVer from the start (start at 0.1.0)
- Use `vim.deprecate()` for future breaking changes
- Document breaking changes clearly

**Documentation:**
- Provide vimdoc (`:h amp-extras`)
- Include installation, configuration, and usage examples
- Document all public API functions
- Use tools like `panvimdoc` to generate from markdown

**Health Checks:**
- Provide `lua/amp-extras/health.lua` for `:checkhealth amp-extras`
- Check for required dependencies (amp.nvim, which-key)
- Check for picker backend (snacks or telescope)
- Report configuration status
- Verify data directory is writable

**Testing:**
- Use `busted` for automated testing
- Test picker abstraction with both backends
- Test input handling with and without NUI.nvim
- Test data persistence and migration
- Test all commands in isolation

**Lua Compatibility:**
- Target Lua 5.1 API (not LuaJIT-specific)
- Set `"runtime.version": "Lua 5.1"` in `.luarc.json`
- Avoid LuaJIT extensions unless gated with `if jit then`

### Picker Abstraction Layer
Must provide unified API that works with both backends:
- `picker.create(opts)` - Creates picker with items, actions, preview
- `picker.format_item(item)` - Formats items for display
- `picker.show_hints(hints)` - Displays hints window
- Internal implementation switches based on config.picker
- Should lazy load picker backend only when first used

### Backward Compatibility
- All existing user commands must continue to work
- Existing keybindings provided as `<Plug>` mappings with suggested defaults
- Existing data files should be migrated automatically if found
- No breaking changes to command names or behavior
- Commands should work immediately without requiring `setup()` call

### Dependencies Detection
Plugin should gracefully handle missing optional dependencies:
- Check for picker (snacks or telescope) on first use
- Check for NUI.nvim, use vim.ui.input if missing
- Show helpful warnings for missing dependencies
- Fail gracefully with clear error messages
- Report dependency status in health check

### Testing Strategy
- Automated testing with `busted` for core utilities
- Test picker abstraction with both snacks and telescope
- Test with NUI.nvim present and absent
- Verify data storage and retrieval
- Ensure all keybindings work
- CI integration for automated testing

## Success Metrics

1. **Code Quality**: Eliminate all significant code duplication (picker setup, terminal execution, input handling, markdown parsing)
2. **Functionality**: Zero regressions - all 40+ current commands work identically
3. **Modularity**: Each command can be maintained independently without touching shared code
4. **Flexibility**: Successfully switch between snacks and telescope by changing one config option
5. **Maintainability**: New features can be added without copy-pasting existing patterns
6. **User Experience**: Plugin feels cohesive with consistent UI/UX across all commands

## Open Questions

1. Should the plugin auto-detect picker preference if not specified (check which is installed)?
2. Should we provide a command to export/import prompts for backup purposes?
3. Should telescope support be implemented immediately or start with snacks only?
4. Are there any specific prompt management features missing that should be added during refactor?
5. Should we add a migration command to help users move from old structure to new structure?
6. Should default prompts be in a separate JSON file or embedded in Lua?
7. Should the plugin support custom prompt categories beyond the defaults?
8. What should the recommended plugin installation look like (lazy.nvim spec example)?
9. Should `<Plug>` mappings follow a naming convention (e.g., `<Plug>(AmpExtrasDashX)` vs `<Plug>(amp-extras-dash-x)`)?
10. Should the health check auto-run on first load to alert users of missing dependencies?
