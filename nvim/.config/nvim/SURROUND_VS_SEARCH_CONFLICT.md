# Surround vs Search Namespace Conflict

## The Problem

You use **`<leader>s*`** for surround operations (mini.surround), but LazyVim uses **`<leader>s*`** for search/picker operations.

This is a **CRITICAL CONFLICT** we need to resolve.

---

## Your Old Surround Mappings

From `mini-surround.lua`:
```lua
sa  -- Add surround
sd  -- Delete surround
sf  -- Find surround (right)
sF  -- Find surround (left)
sh  -- Highlight surround
sr  -- Replace surround
sn  -- Update n lines
```

**Note:** These use `s` prefix, NOT `<leader>s` prefix.

**Wait... are you confusing `s` with `<leader>s`?**

Let me clarify:
- `sa` = just press `s` then `a` (NO leader key)
- `<leader>sa` = press `Space` then `s` then `a` (WITH leader)

---

## LazyVim's `<leader>s*` Search Namespace (26 mappings!)

All of these start with `<leader>s` (Space + s):

### General Search
| Keymap | Function | Description |
|--------|----------|-------------|
| `<leader>sa` | Auto Commands | List autocmds |
| `<leader>sb` | Buffer Lines | Search in current buffer |
| `<leader>sc` | Command History | Recent commands |
| `<leader>sC` | Commands | All commands |
| `<leader>sd` | Document Diagnostics | Errors/warnings in file |
| `<leader>sD` | Workspace Diagnostics | All errors/warnings |
| `<leader>sg` | Grep (root) | Search text in project |
| `<leader>sG` | Grep (cwd) | Search text in directory |
| `<leader>sh` | Help Pages | Vim help |
| `<leader>sH` | Highlight Groups | Color highlights |
| `<leader>sk` | Keymaps | All keymaps |
| `<leader>sl` | LSP Symbols | Document symbols |
| `<leader>sL` | LSP Workspace Symbols | Workspace symbols |
| `<leader>sm` | Jump to Mark | Marks |
| `<leader>sM` | Man Pages | Man pages |
| `<leader>so` | Options | Vim options |
| `<leader>sR` | Resume | Resume last search |
| `<leader>ss` | Goto Symbol | LSP symbols |
| `<leader>sS` | Goto Symbol (workspace) | Workspace symbols |
| `<leader>sw` | Grep Word (root) | Word under cursor |
| `<leader>sW` | Grep Word (cwd) | Word in cwd |

### Telescope-specific (if using telescope extra)
| Keymap | Function | Description |
|--------|----------|-------------|
| `<leader>s"` | Registers | Vim registers |
| `<leader>s:` | Command History | Commands |
| `<leader>s<` | Last Search | Previous search |
| `<leader>sr` | Replace in Files | Find and replace |

---

## The Conflict Resolution

### Option 1: Keep Surround on `s*`, Search on `<leader>s*` (NO CONFLICT!)

**Your surround mappings DON'T have `<leader>`:**
```lua
sa  -- Add surround (just 's' + 'a')
sd  -- Delete surround (just 's' + 'd')
sr  -- Replace surround (just 's' + 'r')
```

**LazyVim search has `<leader>`:**
```lua
<leader>sa  -- Auto commands (Space + 's' + 'a')
<leader>sd  -- Diagnostics (Space + 's' + 'd')
<leader>sr  -- Replace in files (Space + 's' + 'r')
```

**These DON'T conflict!** They use different prefixes.

**HOWEVER, some DO conflict:**
```lua
sh  -- Your surround highlight
<leader>sh  -- LazyVim help pages

sf  -- Your surround find
<leader>sf  -- (not used by LazyVim)
```

**Solution:** This is fine! No real conflict.

---

### Option 2: Move Search Namespace Elsewhere

If you want `<leader>s*` for something else, move LazyVim's search to different prefix:

**Alternative prefixes:**
```lua
<leader>f*  -- "Find" (but you already use this!)
<leader>p*  -- "Pick" (available)
<leader>S*  -- Capital S (available)
<leader>/*  -- Slash prefix (weird but possible)
```

**This is a LOT of work** - 26 mappings to remap!

---

### Option 3: Change Surround Mappings

Move surround to different prefix:

**Options:**
```lua
-- Option A: Use 'z' prefix (available)
za  -- Add surround
zd  -- Delete surround
zr  -- Replace surround

-- Option B: Use 'gs' prefix (text object style)
gsa  -- Add surround
gsd  -- Delete surround
gsr  -- Replace surround

-- Option C: Use leader
<leader>sa  -- Add surround (conflicts with search!)
```

---

## Wait, Let's Check if There's Really a Conflict

Your old config uses:
```lua
sa/sd/sf/sF/sh/sr/sn
```

LazyVim uses:
```lua
<leader>sa/<leader>sd/<leader>sh/etc.
```

**These are DIFFERENT:**
- `sa` = Press `s`, then `a` (2 keys, no leader)
- `<leader>sa` = Press Space, then `s`, then `a` (3 keys, with leader)

**THERE IS NO CONFLICT!** Unless you want to use `<leader>s*` for something else.

---

## Your Statement: "I like having leader+s to work with surrounding"

**Question:** Do you mean:
1. You use `s*` (without leader) for surround? (What you actually do)
2. You WANT to use `<leader>s*` for surround? (Different from current)

If you mean #1: **No conflict, you're good!**

If you mean #2: **Big conflict, need to move all search mappings**

---

## My Questions

### 1. Current Surround Mappings
Your old config uses `sa`, `sd`, `sr` (NO leader key). Is this what you want to keep?

### 2. LazyVim's `<leader>s*` Search Namespace
Do you want to use LazyVim's search namespace? It has useful stuff like:
- `<leader>sd` - Diagnostics picker (errors/warnings)
- `<leader>sw` - Grep word under cursor
- `<leader>sk` - Keymaps picker
- `<leader>sh` - Help picker

### 3. Conflict or No Conflict?
Since `s*` and `<leader>s*` are different, there's technically no conflict. Are you okay with:
- `sa/sd/sr/sh/sf` for surround (no leader)
- `<leader>sd/<leader>sh/<leader>sk` for search (with leader)

Or do you want everything under one prefix?

---

## My Recommendation

### Keep What You Have (No Conflict):
```lua
-- Surround (mini.surround) - NO leader
sa  -- Add surround
sd  -- Delete surround
sr  -- Replace surround
sh  -- Highlight surround
sf/sF  -- Find surround

-- Search (LazyVim) - WITH leader
<leader>sd  -- Diagnostics
<leader>sw  -- Word search
<leader>sh  -- Help
<leader>sk  -- Keymaps
<leader>sg  -- Grep
```

**This works perfectly!** No conflicts.

**BUT** if you want ALL search under `<leader>f*` instead of `<leader>s*`, we can move it. That's a lot of work though.

---

## Alternative: Move Search to `<leader>f*` Subcategories

Instead of LazyVim's flat `<leader>s*`, organize under your `<leader>f*`:

```lua
-- Your current plan:
<leader>ff  -- Find files
<leader>fg  -- Grep
<leader>fb  -- Buffers
<leader>fc  -- Commands
<leader>fk  -- Keymaps
<leader>fh  -- Help

-- Add LazyVim's search features here:
<leader>fd  -- Diagnostics (was <leader>sd)
<leader>fw  -- Word search (was <leader>sw)
<leader>fo  -- Options (was <leader>so)
<leader>fm  -- Marks (was <leader>sm)
```

**This is cleaner** - everything under `<leader>f*` for "find/search".

**But:** Lose LazyVim's nice `<leader>s*` organization.

---

## What I Need From You

**Please clarify:**

1. **Your surround mappings:** Do you use `sa` (no leader) or `<leader>sa` (with leader)?

2. **Do you want LazyVim's `<leader>s*` search namespace?** Or move it to `<leader>f*`?

3. **If moving to `<leader>f*`**, which search features do you want?
   - Diagnostics (`<leader>fd`)?
   - Word search (`<leader>fw`)?
   - Help (`<leader>fh` - you already have this)?
   - Keymaps (`<leader>fk` - you already have this)?
   - Others?

Let me know and I'll update the strategy!
