# Picker Mappings - Complete Analysis

## Your Old Telescope Config (Neovim)

### `<leader>f*` - Find Mappings (15 mappings)

| Keymap | Function | Description | Priority |
|--------|----------|-------------|----------|
| `<leader>ff` | `find_files()` | Find Files | 🔥 CRITICAL |
| `<leader>fg` | `live_grep()` | Live Grep (search text) | 🔥 CRITICAL |
| `<leader>fG` | `grep_string()` | Grep word under cursor | ⭐ HIGH |
| `<leader>fb` | `buffers()` | Find Buffers | 🔥 CRITICAL |
| `<leader>fr` | `oldfiles()` | Recent Files | ⭐ HIGH |
| `<leader>fc` | `commands()` | Commands Palette | ⭐ HIGH |
| `<leader>fk` | `keymaps()` | Find Keymaps | ⭐ HIGH |
| `<leader>fh` | `help_tags()` | Help Tags | 💡 MEDIUM |
| `<leader>fR` | `registers()` | Registers | 💡 MEDIUM |
| `<leader>fp` | `projects()` | Projects (telescope-projects) | ⭐ HIGH |
| `<leader>fi` | `media_files()` | Media Files | ⚡ LOW |
| `<leader>fH` | `highlights()` | Highlights | ⚡ LOW |
| `<leader>fM` | `man_pages()` | Man Pages | ⚡ LOW |
| `<leader>fC` | `colorscheme()` | Colorscheme Picker | 💡 MEDIUM |
| `<leader>fl` | `resume()` | Last Search (resume) | 💡 MEDIUM |
| `<leader>fs` | `search_history()` | Search History | ⚡ LOW |

---

### `<leader>g*` - Git Mappings (4 mappings)

| Keymap | Function | Description | Priority |
|--------|----------|-------------|----------|
| `<leader>gb` | `git_branches()` | Git Branches | ⭐ HIGH |
| `<leader>gc` | `git_commits()` | Git Commits | ⭐ HIGH |
| `<leader>gC` | `git_bcommits()` | Buffer Commits | 💡 MEDIUM |
| `<leader>go` | `git_status()` | Git Status | ⭐ HIGH |

---

### `<leader>l*` - LSP Mappings (3 mappings)

| Keymap | Function | Description | Priority |
|--------|----------|-------------|----------|
| `<leader>ls` | `lsp_document_symbols()` | Document Symbols | ⭐ HIGH |
| `<leader>lS` | `lsp_dynamic_workspace_symbols()` | Workspace Symbols | ⭐ HIGH |
| `<leader>le` | `quickfix()` | Quickfix List | 💡 MEDIUM |

---

## Your VSCode Neovim Mappings

### `<leader>f*` - Find Mappings (11 mappings)

| Keymap | VSCode Command | Description |
|--------|----------------|-------------|
| `<leader>fc` | `showCommands` | Command Palette |
| `<leader>fo` | `files.openFolder` | Open Folder |
| `<leader>fs` | `showAllSymbols` | Find Symbol |
| `<leader>ff` | `quickOpen` | Quick Open Files |
| `<leader>fr` | `quickOpenRecent` | Recent Files |
| `<leader>fw` | `actions.find` | Find Word |
| `<leader>fe` | `emoji.insert` | Emoji Picker |
| `<leader>fp` | `projectManager.listProjects` | Git Projects |
| `<leader>fP` | `projectManager.refreshGitProjects` | Refresh Projects |
| `<leader>fg` | `livegrep.search` | Live Grep |

**Note:** Some overlap with Neovim mappings, some different.

---

## LazyVim Default Picker Mappings (Snacks)

LazyVim uses `snacks.nvim` picker by default. Here are the built-in mappings:

### Core Pickers

| Keymap | Function | Description |
|--------|----------|-------------|
| `<leader><space>` | Find Files | Quick file finder |
| `<leader>/` | Grep (root dir) | Search text in files |
| `<leader>:` | Command History | Recent commands |
| `<leader>,` | Switch Buffer | Buffer picker |
| `<leader>fb` | Buffers | All buffers |
| `<leader>fc` | Config Files | Neovim config files |
| `<leader>ff` | Find Files (root) | Find files in project |
| `<leader>fF` | Find Files (cwd) | Find files in cwd |
| `<leader>fg` | Grep (root dir) | Search text |
| `<leader>fG` | Grep (cwd) | Search text in cwd |
| `<leader>fr` | Recent | Recent files |
| `<leader>fR` | Recent (cwd) | Recent in cwd |

### Git Pickers

| Keymap | Function | Description |
|--------|----------|-------------|
| `<leader>gc` | Commits | Git commits |
| `<leader>gs` | Status | Git status |

### Search Pickers

| Keymap | Function | Description |
|--------|----------|-------------|
| `<leader>sa` | Auto Commands | Autocmds |
| `<leader>sb` | Buffer | Lines in buffer |
| `<leader>sc` | Command History | Recent commands |
| `<leader>sC` | Commands | All commands |
| `<leader>sd` | Document Diagnostics | Buffer diagnostics |
| `<leader>sD` | Workspace Diagnostics | All diagnostics |
| `<leader>sg` | Grep (root) | Search text |
| `<leader>sG` | Grep (cwd) | Search in cwd |
| `<leader>sh` | Help Pages | Vim help |
| `<leader>sH` | Search Highlight Groups | Highlights |
| `<leader>sk` | Keymaps | All keymaps |
| `<leader>sM` | Man Pages | Man pages |
| `<leader>sm` | Jump to Mark | Marks |
| `<leader>so` | Options | Vim options |
| `<leader>sR` | Resume | Last search |
| `<leader>sw` | Grep Word (root) | Word under cursor |
| `<leader>sW` | Grep Word (cwd) | Word in cwd |
| `<leader>uC` | Colorscheme | Theme picker |

---

## Comparison & Conflicts

### Overlapping Keymaps (Same function, different key)

| Your Old | LazyVim | Function |
|----------|---------|----------|
| `<leader>ff` | `<leader><space>` or `<leader>ff` | Find Files |
| `<leader>fg` | `<leader>/` or `<leader>sg` | Live Grep |
| `<leader>fb` | `<leader>,` or `<leader>fb` | Buffers |
| `<leader>fr` | `<leader>fr` | Recent Files ✅ SAME |
| `<leader>fc` | `<leader>sC` | Commands |
| `<leader>fk` | `<leader>sk` | Keymaps |
| `<leader>fh` | `<leader>sh` | Help |
| `<leader>fC` | `<leader>uC` | Colorscheme |
| `<leader>fl` | `<leader>sR` | Resume Last |

### Your Mappings NOT in LazyVim

| Your Keymap | Function | Equivalent? |
|-------------|----------|-------------|
| `<leader>fG` | Grep word under cursor | `<leader>sw` (LazyVim has it, different key) |
| `<leader>fR` | Registers | Not in LazyVim by default |
| `<leader>fp` | Projects | Not in LazyVim (need plugin) |
| `<leader>fi` | Media files | Not in LazyVim |
| `<leader>fH` | Highlights | `<leader>sH` (LazyVim has it) |
| `<leader>fM` | Man pages | `<leader>sM` (LazyVim has it) |
| `<leader>fs` | Search history | `<leader>sc` (LazyVim has it) |
| `<leader>ls` | LSP doc symbols | Not in default LazyVim (LSP handles this differently) |
| `<leader>lS` | LSP workspace symbols | Not in default LazyVim |
| `<leader>le` | Quickfix | Not in default LazyVim |

### LazyVim Features You Don't Have

| LazyVim Keymap | Function | Useful? |
|----------------|----------|---------|
| `<leader><space>` | Quick find files | ⭐ Very fast, different from `<leader>ff` |
| `<leader>/` | Quick grep | ⭐ Very fast, different from `<leader>fg` |
| `<leader>,` | Quick buffer switch | ⭐ Very fast |
| `<leader>s*` | Search category | 💡 Organized search namespace |
| `<leader>sd/sD` | Diagnostics picker | ⭐ Very useful for errors |
| `<leader>sa` | Autocmds | 💡 Debugging tool |
| `<leader>so` | Vim options | 💡 Nice to have |

---

## Strategy Options

### Option 1: "Embrace LazyVim" (Recommended)
**Learn LazyVim's organization, keep some muscle memory**

```lua
-- Keep LazyVim's quick access (learn these):
<leader><space>  → Find files (quick)
<leader>/        → Grep (quick)
<leader>,        → Buffers (quick)

-- Port your critical <leader>f* mappings (muscle memory):
<leader>ff  → Find files (your habit)
<leader>fg  → Live grep (your habit)
<leader>fb  → Buffers (your habit)
<leader>fr  → Recent files (already same!)
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fp  → Projects (need plugin)

-- Use LazyVim's <leader>s* for new stuff:
<leader>sd  → Diagnostics
<leader>sh  → Help
<leader>sk  → Keymaps (or keep <leader>fk)
<leader>sw  → Word under cursor
```

**Pros:**
- ✅ Best of both worlds
- ✅ Learn LazyVim's fast shortcuts (`<space>`, `/`, `,`)
- ✅ Keep muscle memory for main actions
- ✅ Less config to write

**Cons:**
- ❌ Some duplication (two ways to find files)
- ❌ Have to learn new shortcuts

---

### Option 2: "Port Everything"
**Keep 100% of your old mappings, ignore LazyVim defaults**

```lua
-- Disable LazyVim's <leader>s* mappings
-- Port all 22 telescope mappings to snacks
<leader>ff/fg/fG/fb/fr/fc/fk/fh/fR/fp/fi/fH/fM/fC/fl/fs
<leader>gb/gc/gC/go
<leader>ls/lS/le
```

**Pros:**
- ✅ Zero learning curve
- ✅ Muscle memory intact

**Cons:**
- ❌ Miss out on LazyVim's nice shortcuts
- ❌ More config to maintain
- ❌ Don't learn the "LazyVim way"

---

### Option 3: "Hybrid" 
**Keep critical muscle memory, adopt LazyVim for rest**

```lua
-- Adopt LazyVim's quick shortcuts:
<leader><space>  → Find files
<leader>/        → Grep
<leader>,        → Buffers

-- Keep ONLY your most-used <leader>f* mappings:
<leader>ff  → Find files (alias to <space>)
<leader>fg  → Grep (alias to /)
<leader>fb  → Buffers (alias to ,)
<leader>fc  → Commands
<leader>fp  → Projects

-- Everything else: use LazyVim's <leader>s* mappings
<leader>sh  → Help (instead of <leader>fh)
<leader>sk  → Keymaps (instead of <leader>fk)
<leader>sw  → Word (instead of <leader>fG)
<leader>sC  → Commands (instead of <leader>fc)
```

**Pros:**
- ✅ Minimal config
- ✅ Learn LazyVim shortcuts
- ✅ Keep most critical muscle memory

**Cons:**
- ❌ Have to relearn some things
- ❌ Still some duplication

---

## My Recommendation: **Option 1 (Embrace LazyVim)**

### Phase 2: Start with these pickers

**Quick Access (LazyVim defaults - LEARN THESE):**
```lua
<leader><space>  → Find files (fastest)
<leader>/        → Grep (fastest)
<leader>,        → Buffers (fastest)
```

**Muscle Memory (Port from old config):**
```lua
<leader>ff  → Find files
<leader>fg  → Live grep
<leader>fb  → Buffers
<leader>fr  → Recent files
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fp  → Projects (add plugin)
```

**New LazyVim Features (Adopt):**
```lua
<leader>sd  → Diagnostics
<leader>sw  → Word under cursor
```

### Phase 4: Add more if you miss them

Only add these if you actually reach for them:
```lua
<leader>fG  → Grep word (or use <leader>sw?)
<leader>fR  → Registers
<leader>fH  → Highlights
<leader>fM  → Man pages
<leader>fC  → Colorscheme
<leader>fl  → Resume last
```

---

## Git Mappings

**Your old:**
```lua
<leader>gb  → Branches
<leader>gc  → Commits
<leader>gC  → Buffer commits
<leader>go  → Status
```

**LazyVim has:**
```lua
<leader>gc  → Commits ✅ SAME
<leader>gs  → Status (you use <leader>go)
```

**Decision:** Keep your git mappings, they're similar enough.

---

## LSP Symbol Pickers

**Your old:**
```lua
<leader>ls  → Document symbols
<leader>lS  → Workspace symbols
<leader>le  → Quickfix
```

**LazyVim approach:** Uses LSP keymaps directly (not pickers)
- `gd` → Go to definition
- `gr` → References
- `<leader>ca` → Code actions

**Decision:** LazyVim's LSP keymaps might be better. Test first.

---

## Projects Plugin

You use `telescope-projects` for `<leader>fp`. 

**LazyVim alternative:** Snacks has project switching built-in.

**Decision:** Test snacks projects first, add telescope-projects if needed.

---

## Summary Table: What to Implement in Phase 2

| Keymap | Function | Status |
|--------|----------|--------|
| `<leader><space>` | Find files (quick) | ✅ LazyVim default |
| `<leader>/` | Grep (quick) | ✅ LazyVim default |
| `<leader>,` | Buffers (quick) | ✅ LazyVim default |
| `<leader>ff` | Find files | 🔧 Add in Phase 2 |
| `<leader>fg` | Live grep | 🔧 Add in Phase 2 |
| `<leader>fb` | Buffers | 🔧 Add in Phase 2 |
| `<leader>fr` | Recent | ✅ LazyVim has it |
| `<leader>fc` | Commands | 🔧 Add in Phase 2 |
| `<leader>fk` | Keymaps | 🔧 Add in Phase 2 |
| `<leader>fp` | Projects | 🔧 Add in Phase 2 |
| `<leader>sd` | Diagnostics | ✅ LazyVim default (new!) |
| `<leader>sw` | Word under cursor | ✅ LazyVim default (new!) |

**Everything else:** Add in Phase 4 if you miss it.

---

## Next Steps

1. **Review this analysis**
2. **Decide which option (1, 2, or 3)**
3. **Confirm which mappings for Phase 2**
4. **I'll create the picker config file**

What do you think? Which approach resonates with you?
