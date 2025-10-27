# LazyVim Migration Plan - Step by Step

> **Status**: Planning Phase  
> **Migration Strategy**: Slow & Methodical - Review Every Change  
> **Goal**: Maintain VSCode+Neovim parity with custom workflows

---

## 📋 Table of Contents

1. [Phase 1: Core Setup & Language Support](#phase-1-core-setup--language-support)
2. [Phase 2: Essential Plugins & UI](#phase-2-essential-plugins--ui)
3. [Phase 3: Custom Integrations](#phase-3-custom-integrations)
4. [Phase 4: Keymaps Overhaul](#phase-4-keymaps-overhaul)
5. [Phase 5: VSCode Integration](#phase-5-vscode-integration)
6. [Phase 6: Polish & Extras](#phase-6-polish--extras)

---

## Phase 1: Core Setup & Language Support

### 1.1 Enable LazyVim Extras - Languages

**Languages to Enable:**

```lua
-- In lua/config/lazy.lua, add to imports:

-- Primary Languages (Python/Rust focused)
{ import = "lazyvim.plugins.extras.lang.python" }      -- ✅ Includes venv-selector, dap, neotest
{ import = "lazyvim.plugins.extras.lang.rust" }        -- ✅ Rust analyzer

-- Web Development
{ import = "lazyvim.plugins.extras.lang.typescript" }  -- ✅ Uses vtsls, includes DAP
{ import = "lazyvim.plugins.extras.lang.astro" }       -- ✅ Astro framework
{ import = "lazyvim.plugins.extras.lang.tailwind" }    -- ✅ Tailwind CSS

-- Data/Config Languages
{ import = "lazyvim.plugins.extras.lang.json" }        -- ✅ JSON schemas
{ import = "lazyvim.plugins.extras.lang.yaml" }        -- ✅ YAML support
{ import = "lazyvim.plugins.extras.lang.toml" }        -- ✅ TOML support
{ import = "lazyvim.plugins.extras.lang.prisma" }      -- ✅ Prisma ORM

-- Infrastructure
{ import = "lazyvim.plugins.extras.lang.docker" }      -- ✅ Dockerfile & compose
{ import = "lazyvim.plugins.extras.lang.terraform" }   -- ✅ Terraform/HCL

-- Other Languages
{ import = "lazyvim.plugins.extras.lang.elixir" }      -- ✅ Elixir support
{ import = "lazyvim.plugins.extras.lang.gleam" }       -- ✅ Gleam support
{ import = "lazyvim.plugins.extras.lang.typst" }       -- ✅ Typst typesetting
{ import = "lazyvim.plugins.extras.lang.git" }         -- ✅ Git commit messages
{ import = "lazyvim.plugins.extras.lang.markdown" }    -- ✅ Markdown preview
```

**Notes:**
- HTML/CSS included by default with treesitter + Tailwind extra
- Lua configured by default in LazyVim
- Kubernetes is YAML-based (covered by yaml extra)
- Focus on Python/Rust as primary development languages

---

### 1.2 Formatters & Linters

**Enable Extras:**

```lua
-- Formatters (optional, auto-detect based on config files)
{ import = "lazyvim.plugins.extras.formatting.prettier" }  -- ⚠️ Only for legacy projects
{ import = "lazyvim.plugins.extras.linting.eslint" }       -- ⚠️ Only for legacy projects
```

**Custom Formatter Config:**
- **Primary**: Biome (for new projects)
- **Fallback**: Prettier/ESLint (auto-detect based on `.prettierrc` or `.eslintrc`)
- **Python**: Ruff (included in python extra) + mypy
- **Future**: Watch for `ty` (Astral's type checker)

**Action Items:**
- [ ] Create `lua/plugins/formatting.lua` to configure Biome as primary
- [ ] Add auto-detection logic for Prettier/ESLint in old projects
- [ ] Configure mypy linter (add to nvim-lint)
- [ ] Research pyre integration

---

### 1.3 Completion Engine - Blink.cmp

**Enable Extra:**

```lua
{ import = "lazyvim.plugins.extras.coding.blink" }
```

**Critical Keybindings (MUST configure):**
```lua
-- In completion menu:
<C-j>  -- Next suggestion (down)
<C-k>  -- Previous suggestion (up)
<Tab>  -- Accept suggestion
```

**Notes:**
- LazyVim uses blink.cmp (NOT blink-cmp) in extras
- Requires `curl` (already installed)
- Fast, native completion engine
- **MUST** override default keybindings to match user's workflow

**Action Items:**
- [ ] Create `lua/plugins/blink.lua` to configure custom keybindings
- [ ] Map `<C-j>/<C-k>` for navigation
- [ ] Map `<Tab>` for accepting suggestions
- [ ] Test in insert mode with completions

---

## Phase 2: Essential Plugins & UI

### 2.1 File Explorer - Oil.nvim (Primary)

**Custom Plugin:**
- Oil.nvim is NOT in LazyVim extras → Add as custom plugin
- Keep Snacks Explorer as backup

**Configuration:**
- **Oil keybinding**: `-` (opens oil in current buffer's directory)
- **Show hidden files**: Enabled by default
- **Snacks Explorer**: `<leader>pv` (like netrw's `:Explore`)

**Action Items:**
- [ ] Create `lua/plugins/oil.lua`
- [ ] Port oil configuration from old config
- [ ] Set `-` to open Oil
- [ ] Set `<leader>pv` for Snacks Explorer
- [ ] Ensure show_hidden = true in Oil config

---

### 2.2 Picker - Snacks Picker

**Status:** ✅ Already default in LazyVim (via snacks.nvim)

**Keybinding Discussion:**
- User uses `C-e` or `C-b` for picker in VSCode
- LazyVim default: `<leader><space>` for find files
- Need to decide: `C-e`, `C-b`, or keep LazyVim default?

**Considerations:**
- `C-e` might conflict with Vim's scroll down
- `C-b` might conflict with Vim's scroll up / tmux prefix
- VSCode uses `C-p` for command palette (picker)

**Questions:**
- [ ] Try LazyVim's `<leader><space>` first?
- [ ] Or immediately map to `C-e` or `C-b`?
- [ ] What about `C-p` (more VSCode-like)?

**Action Items:**
- [ ] **DISCUSS** picker keybinding before implementing
- [ ] Ensure picker works with Oil integration

---

### 2.3 Dashboard - Snacks Dashboard

**Custom ASCII Art:**

```
 █     █░ ██▀███   ▄▄▄      ▄▄▄█████▓ ██░ ██ 
▓█░ █ ░█░▓██ ▒ ██▒▒████▄    ▓  ██▒ ▓▒▓██░ ██▒
▒█░ █ ░█ ▓██ ░▄█ ▒▒██  ▀█▄  ▒ ▓██░ ▒░▒██▀▀██░
░█░ █ ░█ ▒██▀▀█▄  ░██▄▄▄▄██ ░ ▓██▓ ░ ░▓█ ░██ 
░██▒██▓ ░██▓ ▒██▒ ▓█   ▓██▒  ▒██▒ ░ ░▓█▒░██▓ 
░ ▓░▒ ▒  ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░  ▒ ░░    ▒ ░░▒░▒
  ▒ ░ ░    ░▒ ░ ▒░  ▒   ▒▒ ░    ░     ▒ ░▒░ ░
  ░   ░    ░░   ░   ░   ▒     ░       ░  ░░ ░
  ░       ░           ░  ░          ░  ░  ░  
```

**Action Items:**
- [ ] Create `lua/plugins/snacks.lua` to override dashboard config
- [ ] Port ASCII art from old alpha config
- [ ] Configure dashboard footer: `https://github.com/wrath-codes`
- [ ] Add startup time display (like old config)

---

### 2.4 Git Tools - LazyGit (Try First)

**Strategy:**
- **Try LazyGit first** (LazyVim default)
- Move to Neogit if LazyGit doesn't fit workflow
- LazyVim has great LazyGit integration out of the box

**Action Items:**
- [ ] Use LazyVim's default LazyGit setup
- [ ] Test LazyGit workflow for a few days
- [ ] **Decision Point**: If LazyGit doesn't work, port Neogit config
- [ ] Document which git tool we settled on

---

### 2.5 Modicator - Cursor Line Number Color

**Custom Plugin:**
- Changes cursor line number color based on mode
- NOT in LazyVim by default

**Old Config:**
```lua
-- Normal mode: Blue (#388bfd)
-- Insert mode: Green (from theme)
-- Visual mode: Purple (from theme)
```

**Action Items:**
- [ ] Create `lua/plugins/modicator.lua`
- [ ] Port exact config from old setup
- [ ] Verify color scheme integration

---

### 2.6 UI Extras to Enable

**LazyVim Extras:**

```lua
{ import = "lazyvim.plugins.extras.ui.edgy" }              -- ⚠️ Optional: Window layout
{ import = "lazyvim.plugins.extras.ui.mini-indentscope" }  -- ✅ Indent scope (replaces hlchunk?)
```

**Decision Points:**
- [ ] Review if `mini-indentscope` replaces your old `hlchunk` plugin
- [ ] Decide on `edgy.nvim` for window management (alternative to winshift?)

---

## Phase 3: Custom Integrations

### 3.1 Harpoon 2 Integration

**Core Setup:**
- Harpoon 2 is available as LazyVim extra: `lazyvim.plugins.extras.editor.harpoon2`

**Custom Lualine Integration (TO DISCUSS):**

**Features from Old Config (Subject to Review):**
1. Custom tabline showing 4 harpoon marks
2. Visual indicators:
   - Active file: `[󰛢] filename` (colored purple)
   - Inactive files: `7/8/9/0 filename` (colored grey)
   - Empty slots: `[+] [Empty]`
3. Custom highlight groups with Catppuccin colors

**Questions to Discuss:**
- [ ] Do we want harpoon in tabline or somewhere else?
- [ ] Keep 4-mark limit or make it dynamic?
- [ ] Keep the visual style or simplify?
- [ ] Should we use LazyVim's default harpoon setup first, then customize?

**Keymaps - 8 Harpoons Total:**
```lua
-- CONFIRMED: Use 1-4 and 7-0 for 8 total marks
1           -- Jump to mark 1
2           -- Jump to mark 2
3           -- Jump to mark 3
4           -- Jump to mark 4
7           -- Jump to mark 5
8           -- Jump to mark 6
9           -- Jump to mark 7
0           -- Jump to mark 8

-- Add/Edit (TO DISCUSS)
<leader>ha  -- Add mark (with notification)
<leader>he  -- Edit harpoon list
<C-S-P>     -- Previous harpoon mark
<C-S-N>     -- Next harpoon mark
```

**Questions:**
- [ ] Check LazyVim's harpoon extra default keymaps first
- [ ] Are number keys 1-4 + 7-0 still best choice?
- [ ] Keep `<leader>ha/he` or adjust?

**Action Items:**
- [ ] Enable harpoon2 extra
- [ ] Test LazyVim's default harpoon setup first
- [ ] **DISCUSS** all keybindings before implementing
- [ ] **DISCUSS** lualine integration approach
- [ ] Only then create custom config

---

### 3.2 Lualine Customization

**Approach:** Start with LazyVim defaults, discuss customizations

**LazyVim Default Sections:**
- Section A: Mode
- Section B: Git branch, diff, diagnostics  
- Section C: Filename, navic (breadcrumbs)
- Section X: Encoding, fileformat
- Section Y: Progress, location
- Section Z: Time (optional)
- Tabline: Buffers (if bufferline disabled)

**CONFIRMED Customizations:**

1. **Harpoon Tabline (Top Bar)**
   - Keep custom harpoon tabline from old config
   - Shows all 8 harpoon marks at top
   - Port `lua/utils/lualine/harpoon.lua` module

2. **Two Bars Setup**
   - **Top bar (tabline)**: Harpoon marks
   - **Bottom bar (statusline)**: LazyVim defaults
   
3. **Time Component**
   - Add time display (format: `HH:MM` or similar)
   - NOT full datetime, just time

4. **Breadcrumbs - Use Navic**
   - Enable `editor.navic` extra for breadcrumbs
   - User doesn't like breadcrumbs in lualine
   - Navic shows them separately

**Keep LazyVim Defaults For:**
- Filename display (relative path is fine)
- Filetype display (no need for uppercase)
- All other components

**Questions:**
- [ ] Should we enable navic extra for breadcrumbs?
- [ ] Where exactly should time display in bottom bar?
- [ ] Any other tweaks needed for two-bar setup?

**Action Items:**
- [ ] Use LazyVim's default lualine first
- [ ] Identify what we actually need/want to customize
- [ ] **DISCUSS** each customization individually
- [ ] Only create overrides for things we genuinely want changed

---

### 3.3 Window Management

**Requirements:**
- VSCode: `C-S-h/j/k/l` to move windows
- Neovim: Similar window movement/swapping

**Options:**
1. **winshift.nvim** (mentioned by user)
2. **LazyVim default**: `<C-h/j/k/l>` for navigation
3. **Edgy.nvim**: Window layout management (extra)

**Action Items:**
- [ ] Research winshift.nvim capabilities
- [ ] Compare with LazyVim's window keymaps
- [ ] **Decision Point**: Winshift vs native vs edgy.nvim
- [ ] Configure consistent keymaps between Neovim/VSCode

---

## Phase 4: Keymaps Overhaul

> **Critical Phase**: User dislikes `[` and `]` defaults

### 4.1 Current LazyVim Defaults to Review

**Navigation (using `[` and `]`):**
```lua
-- LazyVim defaults we DON'T like:
]b  -- Next buffer
[b  -- Previous buffer
]d  -- Next diagnostic
[d  -- Previous diagnostic
]t  -- Next todo comment
[t  -- Previous todo comment
```

**Other Defaults:**
```lua
<leader><space>  -- Find files (snacks picker)
<leader>/        -- Grep (snacks picker)
<leader>bb       -- Switch buffers
<leader>e        -- Explorer (neo-tree by default, we'll use Oil)
<C-h/j/k/l>      -- Window navigation
```

### 4.2 Old Config Keymaps to Preserve

**Core Movement:**
```lua
n/N/*/#/g*/g#    -- Center screen after search
<C-d>/<C-u>      -- Center screen on half-page jumps
</<>             -- Stay in visual mode after indent
J/K (visual)     -- Move lines up/down
```

**CRITICAL Custom Bindings (Phase 1):**
```lua
<leader>.        -- CRITICAL: Quickfix/Code Actions menu (MUST HAVE)
<C-j>/<C-k>      -- CRITICAL: Navigate suggestions (up/down in completion)
<Tab>            -- CRITICAL: Accept suggestion/completion
<Esc>            -- Clear highlights (keep)
gB               -- Replace word under cursor in buffer (keep)
<leader>==       -- Select entire file
<C-;> (terminal) -- Exit terminal mode (keep)
```

**To Review Later:**
```lua
<leader>+/-      -- Increment/decrement numbers (review in Phase 4)
```

**Terminal Keybindings TO DISCUSS:**
```lua
-- User wants C-t or C-S-t for terminal
-- VSCode uses: C-t (toggle), C-S-t (maximize)
-- LazyVim default: <C-/> or <C-_> for terminal

-- Options:
C-t          -- Toggle terminal
C-S-t        -- Maximize terminal
-- OR keep LazyVim's <C-/> / <C-_>
```

**Conflicts to Consider:**
- `C-t` - Vim default: jump to older position in tag stack
- Do we use tags enough to care?

**Questions:**
- [ ] Map `C-t` / `C-S-t` for terminal (VSCode-like)?
- [ ] Or keep LazyVim's `<C-/>` default?
- [ ] Review LazyVim's existing increment/decrement keymaps
- [ ] Do we want surround mappings? Need to discuss conflicts with LazyVim
- [ ] Move lines up/down - keep or use LazyVim's?

**Window Management (Neovim):**
```lua
<Tab>/<S-Tab>          -- Next/previous tab
<leader>m[hjkl]        -- Navigate windows
<C-Up/Down/Left/Right> -- Resize windows
```

### 4.3 New Keymap Strategy

**Principles:**
1. **No `[` and `]`** for frequent operations
2. **Leader-based groups** for discoverability
3. **Consistent Neovim ↔ VSCode** keymaps

**Action Items:**
- [ ] Create `lua/config/keymaps.lua` with all custom keymaps
- [ ] Map navigation to `<leader>` prefixes instead of `[`/`]`
- [ ] Port all old keymaps from `core/keymaps.lua`
- [ ] Document all keybinds in this plan
- [ ] Test conflicts with LazyVim defaults

**CONFIRMED Remaps - Leader-based Navigation:**

| Old LazyVim | New Keymap | Action |
|-------------|------------|--------|
| `]b` / `[b` | `<leader>bn` / `<leader>bN` | Next/Previous buffer |
| `]d` / `[d` | `<leader>dn` / `<leader>dN` | Next/Previous diagnostic |
| `]t` / `[t` | `<leader>tn` / `<leader>tN` | Next/Previous todo |
| `]q` / `[q` | `<leader>qn` / `<leader>qN` | Next/Previous quickfix |

**Note:** Using capital N for "previous" to match shift pattern

---

## Phase 5: VSCode Integration

### 5.1 Enable VSCode Extra

```lua
{ import = "lazyvim.plugins.extras.vscode" }
```

**What This Provides:**
- Minimal plugin loading in VSCode
- VSCode-aware keymaps for find/search/terminal
- Disabled UI elements (colorscheme, status, etc.)

---

### 5.2 Custom VSCode Extensions

**Old Config Structure:**
```
vscode/
├── api/          -- VSCode action wrappers (22 modules)
├── keymaps/      -- Keymap definitions (22 modules)
├── autocmds.lua  -- VSCode-specific autocmds
└── util.lua      -- VSCodeNotify, VSCodeMap helpers
```

**Coverage:**
- Editing, formatting, refactoring
- Git operations
- Python/Java/SQL language-specific
- Window/editor management
- Harpoon integration
- Oil integration
- Server/remote commands
- Markdown preview

**Action Items:**
- [ ] Create `lua/vscode/` directory structure
- [ ] Port `util.lua` (VSCodeNotify/Map helpers)
- [ ] Port all API modules from old config
- [ ] Port all keymap modules
- [ ] Port autocmds
- [ ] **Add**: Window movement keymaps `<C-S-h/j/k/l>`

---

### 5.3 VSCode-Specific Keymaps

**Preserve All Old Keymaps:**

**Editing:**
```lua
<leader>fae  -- Find and Replace
<leader>frn  -- Rename
<leader>frf  -- Refactor
<leader>fax  -- Auto Fix
<leader>.    -- Quick Fix
za           -- Toggle Fold
```

**Editor Management:**
```lua
<Tab>/<S-Tab>       -- Next/Previous editor
<leader>wc          -- Close editor
<leader>wa          -- Close all editors
<leader>wo          -- Close other editors
```

**Window Navigation & Movement (Already Configured in VSCode):**

From `keybindings.json`:
```json
// Navigate between editor groups
"ctrl+h" → workbench.action.focusLeftGroup
"ctrl+l" → workbench.action.focusRightGroup
"ctrl+k" → workbench.action.focusAboveGroup
"ctrl+j" → workbench.action.focusBelowGroup

// Move editor to different groups
"ctrl+shift+h" → workbench.action.moveEditorToLeftGroup
"ctrl+shift+l" → workbench.action.moveEditorToRightGroup
"ctrl+shift+k" → workbench.action.moveEditorToAboveGroup
"ctrl+shift+j" → workbench.action.moveEditorToBelowGroup

// Resize editor groups
"ctrl+shift+alt+h" → workbench.action.increaseViewWidth
"ctrl+shift+alt+l" → workbench.action.decreaseViewWidth
"ctrl+shift+alt+k" → workbench.action.decreaseViewHeight
"ctrl+shift+alt+j" → workbench.action.increaseViewHeight
```

**Neovim Mappings to Match VSCode:**
```lua
-- In VSCode mode, map to VSCode actions
<C-h>      -- VSCode: focus left group
<C-l>      -- VSCode: focus right group
<C-k>      -- VSCode: focus above group
<C-j>      -- VSCode: focus below group

<C-S-h>    -- VSCode: move editor to left group
<C-S-l>    -- VSCode: move editor to right group
<C-S-k>    -- VSCode: move editor to above group
<C-S-j>    -- VSCode: move editor to below group
```

**Action Items:**
- [ ] Port all VSCode keymaps from old config
- [ ] Ensure window navigation/movement keymaps call correct VSCode actions
- [ ] Test that `<C-h/j/k/l>` works for navigation
- [ ] Test that `<C-S-h/j/k/l>` works for moving editors
- [ ] Verify consistency between Neovim and VSCode

---

## Phase 6: Polish & Extras

### 6.1 Motion Plugins - Decision Point

**Options:**
1. **Flash** (LazyVim default) - Enhanced f/t motions with labels
2. **Hop** (old config) - Jump to any location
3. **Leap** (LazyVim extra) - Alternative to flash

**Action Items:**
- [ ] Test Flash with default config
- [ ] Compare with old Hop workflow
- [ ] **Decision**: Keep flash, switch to hop, or try leap
- [ ] Configure chosen plugin

---

### 6.2 Extras to Consider

**UI:**
```lua
{ import = "lazyvim.plugins.extras.ui.mini-animate" }  -- Smooth animations
```

**Editor:**
```lua
{ import = "lazyvim.plugins.extras.editor.illuminate" }  -- Highlight word under cursor
{ import = "lazyvim.plugins.extras.editor.inc-rename" } -- Incremental LSP rename
{ import = "lazyvim.plugins.extras.editor.navic" }      -- LSP breadcrumbs
{ import = "lazyvim.plugins.extras.editor.outline" }    -- Symbol outline
```

**Coding:**
```lua
{ import = "lazyvim.plugins.extras.coding.mini-surround" } -- Surround text objects
{ import = "lazyvim.plugins.extras.coding.yanky" }         -- Enhanced yank/paste
```

**Action Items:**
- [ ] Review each extra individually
- [ ] Test if illuminate replaces old illuminate plugin
- [ ] Test if navic works for breadcrumbs
- [ ] Decide on each extra one-by-one

---

### 6.3 Old Plugins Review

**From Old Config - Decide Fate:**

| Plugin | Status | LazyVim Equivalent? | Keep? |
|--------|--------|---------------------|-------|
| `autopairs` | ✅ Built-in | `mini.pairs` | ❌ Remove |
| `autotag` | ✅ Built-in | `nvim-ts-autotag` | ❌ Remove |
| `breadcrumbs` | ⚠️ Extra | `navic` extra | 🔍 Test |
| `comment` | ✅ Built-in | `ts-comments.nvim` | ❌ Remove |
| `diffview` | ❓ Custom | None | ✅ Keep |
| `gitsigns` | ✅ Built-in | Default | ❌ Remove |
| `illuminate` | ⚠️ Extra | `illuminate` extra | 🔍 Enable |
| `incline` | ❓ Custom | None | ❓ Decide |
| `lab` | ❓ Custom | None | ❓ Decide |
| `markdown-preview` | ⚠️ Built-in | Markdown extra | ❌ Remove |
| `render-markdown` | ⚠️ Built-in | Markdown extra | ❌ Remove |
| `project` | ❓ Custom | None | ❓ Decide |
| `tabby` | ❓ Custom | None | ❓ Decide |
| `text-objects` | ✅ Built-in | `mini.ai` | ❌ Remove |
| `toggleterm` | ⚠️ Snacks | `snacks terminal` | ❓ Compare |
| `transparent` | ❓ Custom | None | ❓ Decide |
| `ufo` | ❌ Not needed | User confirmed | ❌ Remove |
| `venv-selector` | ✅ Built-in | Python extra | ❌ Remove |
| `gitlinker` | ❓ Custom | None | ❓ Decide |
| `zenmode` | ✅ Built-in | LazyVim default | ❌ Remove |
| `twilight` | ✅ Built-in | LazyVim default | ❌ Remove |
| `fidget` | ⚠️ Extra | `lsp` config | 🔍 Check |
| `dressing` | ⚠️ Extra | LazyVim | 🔍 Check |
| `noice` | ✅ Built-in | Default UI | ❌ Remove |

**Action Items:**
- [ ] Test each "🔍" plugin
- [ ] Decide on each "❓" plugin
- [ ] Document why keeping/removing

---

### 6.4 Colorscheme - Catppuccin Mocha

**Decision:** ✅ Use LazyVim's built-in Catppuccin Mocha support

**Configuration:**
- LazyVim includes Catppuccin by default
- Simply set `vim.g.lazyvim_colorscheme = "catppuccin-mocha"` in options
- No need for custom plugin file - LazyVim handles it perfectly

**Action Items:**
- [ ] Set colorscheme to `catppuccin-mocha` in `lua/config/options.lua`
- [ ] Test that it matches VSCode appearance
- [ ] (Optional) Override transparency settings if needed via LazyVim's colorscheme config

---

## 🎯 Implementation Checklist

### Pre-Migration
- [ ] Backup current LazyVim config
- [ ] Ensure old config is safe at `~/old/nvim`
- [ ] Review this plan completely

### Phase 1: Languages & Core
- [ ] Enable all language extras
- [ ] Configure Biome/Prettier auto-detection
- [ ] Setup mypy linter
- [ ] Enable blink.cmp with custom keybindings (`<C-j/k>` for nav, `<Tab>` for accept)
- [ ] Setup `<leader>.` for quickfix/code actions
- [ ] Configure critical keybindings (select all, clear highlights, etc.)

### Phase 2: UI & Plugins
- [ ] Setup Oil.nvim
- [ ] Configure Snacks dashboard with ASCII art
- [ ] Setup Neogit
- [ ] Add Modicator
- [ ] Review UI extras

### Phase 3: Integrations
- [ ] Setup Harpoon 2 with custom tabline
- [ ] Customize Lualine (bubbles theme, components)
- [ ] Configure window management

### Phase 4: Keymaps
- [ ] Port core keymaps from old config
- [ ] Remap `[`/`]` navigation
- [ ] Test all keybinds
- [ ] Document final keymap reference

### Phase 5: VSCode
- [ ] Enable VSCode extra
- [ ] Port entire VSCode integration
- [ ] Add window movement keymaps
- [ ] Test in VSCode

### Phase 6: Polish
- [ ] Decide on motion plugin
- [ ] Review and enable extras
- [ ] Clean up old plugin references
- [ ] Finalize colorscheme

---

## 📝 Decision Log

Track all decisions made during migration:

| Date | Decision | Reasoning |
|------|----------|-----------|
| ✅ | Picker: Snacks | User preference, LazyVim default |
| ✅ | Git: Neogit (primary) | User preference over LazyGit |
| ✅ | Completion: Blink.cmp | Fast, user familiar |
| ✅ | File Explorer: Oil (primary) | Must-have, Snacks as backup |
| ✅ | Dashboard: Snacks with custom art | Keep branding |
| ✅ | Colorscheme: Catppuccin Mocha | VSCode parity, user preference |
| ✅ | VSCode window movement | Already configured in keybindings.json |
| ✅ | Search namespace: `<leader>s*` | Keep all LazyVim defaults |
| ✅ | Completion nav: `<C-j/k>` | Must-have for suggestions |
| ✅ | Quickfix: `<leader>.` | Critical keybinding, cannot live without |
| ✅ | Accept completion: `<Tab>` | Standard workflow |
| TBD | Motion plugin | TBD - test Flash vs Hop |
| TBD | Window management (Neovim) | TBD - test winshift vs edgy |
| TBD | Copilot integration | Check if still needed |

---

## 🔗 Resources

- [LazyVim Docs](https://www.lazyvim.org/)
- [LazyVim GitHub](https://github.com/LazyVim/LazyVim)
- [Keymaps Reference](https://www.lazyvim.org/keymaps)
- [Configuration Guide](https://www.lazyvim.org/configuration)
- [Extras Guide](https://www.lazyvim.org/extras)

---

## ⚠️ Important Notes

1. **Never overwrite old config** - It lives safely at `~/old/nvim`
2. **Test incrementally** - Don't change everything at once
3. **Document changes** - Update this plan as we go
4. **VSCode parity** - Always ensure VSCode integration works
5. **Slow & steady** - User preference, respect it
6. **DO NOT ASSUME KEYBINDINGS** - Question and discuss every keybinding choice, even from old config
7. **Debate before implementing** - Discuss lualine, harpoon, and all customizations thoroughly
8. **Start minimal** - Use defaults first, add only what we genuinely need

---

**Next Steps**: Review this plan together, discuss any concerns, then start Phase 1 when ready.
