# LazyVim's Complete `<leader>s*` Search Namespace

All mappings that start with `<leader>s` (Space + s):

---

## Core Search Mappings (Always Available)

### Text/Code Search
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sg` | Grep (root dir) | Search text in project root | 🔥 CRITICAL |
| `<leader>sG` | Grep (cwd) | Search text in current directory | ⭐ HIGH |
| `<leader>sw` | Grep Word (root) | Search word under cursor in root | 🔥 CRITICAL |
| `<leader>sW` | Grep Word (cwd) | Search word under cursor in cwd | ⭐ HIGH |
| `<leader>sb` | Buffer Lines | Search lines in current buffer | 💡 MEDIUM |

### Diagnostics & Errors
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sd` | Document Diagnostics | Errors/warnings in current file | 🔥 CRITICAL |
| `<leader>sD` | Workspace Diagnostics | All errors/warnings in workspace | 🔥 CRITICAL |

### LSP Symbols
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>ss` | Goto Symbol | Jump to symbol in buffer | ⭐ HIGH |
| `<leader>sS` | Goto Symbol (workspace) | Jump to symbol in workspace | ⭐ HIGH |
| `<leader>sl` | LSP Document Symbols | List symbols in document | 💡 MEDIUM |
| `<leader>sL` | LSP Workspace Symbols | List symbols in workspace | 💡 MEDIUM |

### Documentation & Help
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sh` | Help Pages | Search Neovim help | ⭐ HIGH |
| `<leader>sM` | Man Pages | Search man pages | 💡 MEDIUM |

### Commands & Keymaps
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sC` | Commands | List all commands | ⭐ HIGH |
| `<leader>sc` | Command History | Recent commands | 💡 MEDIUM |
| `<leader>sk` | Keymaps | Search all keymaps | ⭐ HIGH |

### History & Resume
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sR` | Resume | Resume last search | 💡 MEDIUM |
| `<leader>s:` | Command History | Command history | ⚡ LOW |
| `<leader>s<` | Last Search | Previous search | ⚡ LOW |

### Vim Internals
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sa` | Auto Commands | List autocmds | 💡 MEDIUM |
| `<leader>so` | Options | Search vim options | 💡 MEDIUM |
| `<leader>sH` | Highlight Groups | Search highlight groups | 💡 MEDIUM |
| `<leader>sm` | Marks | Jump to marks | 💡 MEDIUM |
| `<leader>s"` | Registers | View registers | 💡 MEDIUM |

### Find & Replace
| Keymap | Function | Description | Usefulness |
|--------|----------|-------------|------------|
| `<leader>sr` | Replace in Files | Find and replace | ⭐ HIGH |

---

## Total Count: **26 mappings** using `<leader>s*`

---

## Organized by Usefulness

### 🔥 CRITICAL (Must-have)
```
<leader>sg  → Grep in project
<leader>sw  → Grep word under cursor
<leader>sd  → Document diagnostics
<leader>sD  → Workspace diagnostics
```

### ⭐ HIGH (Very useful)
```
<leader>sG  → Grep in cwd
<leader>sW  → Grep word in cwd
<leader>ss  → Goto symbol
<leader>sS  → Goto workspace symbol
<leader>sh  → Help pages
<leader>sC  → Commands
<leader>sk  → Keymaps
<leader>sr  → Replace in files
```

### 💡 MEDIUM (Nice to have)
```
<leader>sb  → Buffer lines
<leader>sl  → Document symbols
<leader>sL  → Workspace symbols
<leader>sM  → Man pages
<leader>sc  → Command history
<leader>sR  → Resume search
<leader>sa  → Autocmds
<leader>so  → Options
<leader>sH  → Highlights
<leader>sm  → Marks
<leader>s"  → Registers
```

### ⚡ LOW (Rarely used)
```
<leader>s:  → Command history (duplicate)
<leader>s<  → Last search
```

---

## Overlap with Your `<leader>f*` Mappings

### Functions You Already Have
| LazyVim | Your Old | Function | Keep Which? |
|---------|----------|----------|-------------|
| `<leader>sh` | `<leader>fh` | Help | Either works |
| `<leader>sC` | `<leader>fc` | Commands | Either works |
| `<leader>sk` | `<leader>fk` | Keymaps | Either works |
| `<leader>sM` | `<leader>fM` | Man pages | Either works |
| `<leader>sH` | `<leader>fH` | Highlights | Either works |
| `<leader>s"` | `<leader>fR` | Registers | Different implementations |

### New Functions LazyVim Adds
| LazyVim | Function | Do You Want This? |
|---------|----------|-------------------|
| `<leader>sd` | Diagnostics | 🔥 Very useful |
| `<leader>sD` | Workspace diagnostics | 🔥 Very useful |
| `<leader>sw` | Grep word | 🔥 Very useful (you have `<leader>fG`) |
| `<leader>ss` | Goto symbol | ⭐ Useful |
| `<leader>sr` | Replace in files | ⭐ Useful |
| `<leader>sa` | Autocmds | 💡 Debugging tool |
| `<leader>so` | Options | 💡 Debugging tool |
| `<leader>sb` | Buffer lines search | 💡 Nice to have |

---

## Decision Matrix

### Option 1: Keep All LazyVim `<leader>s*` (Recommended)
**What you get:**
- All 26 search functions under `<leader>s*`
- Your surround stays on `sa/sd/sr` (no leader)
- Keep your `<leader>f*` for file/project finding
- Clean separation: `<leader>f*` = files, `<leader>s*` = search/symbols

**Pros:**
- ✅ Best organization
- ✅ No conflicts
- ✅ Get all LazyVim features
- ✅ Less config to write

**Cons:**
- ❌ Some duplication (`<leader>fh` vs `<leader>sh`)
- ❌ Need to remember both prefixes

---

### Option 2: Move Useful Search to `<leader>f*`
**Reorganize like this:**
```lua
-- Keep <leader>f* for all finding:
<leader>ff  → Find files
<leader>fg  → Grep
<leader>fb  → Buffers
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fh  → Help
<leader>fr  → Recent

-- Add from <leader>s*:
<leader>fd  → Diagnostics (was <leader>sd)
<leader>fw  → Word under cursor (was <leader>sw)
<leader>fs  → Symbols (was <leader>ss)
<leader>fo  → Options (was <leader>so)

-- Disable rest of <leader>s* mappings
```

**Pros:**
- ✅ Everything under one prefix (`<leader>f*`)
- ✅ Simpler mental model
- ✅ `<leader>s*` freed up (if you want it for something)

**Cons:**
- ❌ More config to write
- ❌ Miss out on some LazyVim features
- ❌ Conflicts: `<leader>fs` already search history in your old config

---

### Option 3: Hybrid - Keep Critical Search, Disable Rest
**Keep only the critical ones:**
```lua
-- LazyVim <leader>s* (keep these):
<leader>sd  → Diagnostics
<leader>sD  → Workspace diagnostics
<leader>sw  → Word search
<leader>sr  → Replace in files

-- Disable the rest, use your <leader>f* instead
```

**Pros:**
- ✅ Get best LazyVim features
- ✅ Less duplication
- ✅ Simpler keymap space

**Cons:**
- ❌ Still some config work
- ❌ Lose some nice features

---

## What Each Option Looks Like

### Option 1: Keep Everything
```lua
-- Your pickers (<leader>f*):
<leader>ff  → Find files
<leader>fg  → Live grep  
<leader>fb  → Buffers
<leader>fr  → Recent
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fh  → Help
<leader>fp  → Projects

-- LazyVim search (<leader>s*) - ALL 26 mappings
<leader>sd  → Diagnostics
<leader>sw  → Word search
<leader>sg  → Grep (duplicate of <leader>fg)
<leader>sh  → Help (duplicate of <leader>fh)
<leader>sk  → Keymaps (duplicate of <leader>fk)
... (and 21 more)

-- Surround (s* - no leader):
sa/sd/sr/sf/sh/sn
```

### Option 2: Consolidate to `<leader>f*`
```lua
-- Everything under <leader>f*:
<leader>ff  → Find files
<leader>fg  → Grep
<leader>fw  → Word search (NEW)
<leader>fb  → Buffers
<leader>fr  → Recent
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fh  → Help
<leader>fd  → Diagnostics (NEW)
<leader>fp  → Projects
<leader>fs  → Symbols (NEW)
<leader>fo  → Options (NEW)

-- Disable all <leader>s*

-- Surround (s* - no leader):
sa/sd/sr/sf/sh/sn
```

### Option 3: Critical Search Only
```lua
-- Your pickers (<leader>f*):
<leader>ff  → Find files
<leader>fg  → Live grep
<leader>fb  → Buffers
<leader>fr  → Recent
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fh  → Help
<leader>fp  → Projects

-- Critical LazyVim search (<leader>s*) - only 4:
<leader>sd  → Diagnostics
<leader>sD  → Workspace diagnostics
<leader>sw  → Word search
<leader>sr  → Replace in files

-- Surround (s* - no leader):
sa/sd/sr/sf/sh/sn
```

---

## My Recommendation: **Option 1 (Keep Everything)**

Why?
1. **Your surround doesn't conflict** - it uses `s*` without leader
2. **LazyVim's organization is good** - `<leader>s*` for search makes sense
3. **Less work** - no config needed, just use it
4. **You get everything** - all 26 features available

The "duplication" (`<leader>fh` vs `<leader>sh`) doesn't matter - you'll naturally use one or the other.

---

## Questions for You

1. **Do you want ALL 26 `<leader>s*` search mappings?**
   - Or only the critical ones (diagnostics, word search, etc.)?

2. **Is duplication okay?**
   - Example: Both `<leader>fg` and `<leader>sg` for grep?
   - Or should we remove duplicates?

3. **Do you need `<leader>s*` prefix for something else?**
   - If yes, we move search to `<leader>f*`
   - If no, keep LazyVim's `<leader>s*`

Let me know your thoughts!
