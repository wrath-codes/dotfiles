# Keybinding Strategy - VSCode & Neovim Parity

## Your Current VSCode Setup

### Explorer/Sidebar
```json
Ctrl+b  → workbench.action.toggleSidebarVisibility (toggle sidebar on/off)
Ctrl+e  → workbench.view.explorer (open file explorer)
```

### Window Navigation
```json
Ctrl+h/j/k/l       → Focus left/down/up/right editor group
Ctrl+Shift+h/j/k/l → Move editor to left/down/up/right group
```

### Terminal
```json
Ctrl+t     → Toggle terminal (from your settings)
Ctrl+Shift+t → Maximize terminal
```

---

## Your Neovim VSCode Keymaps (Old Config)

### Find/Picker Commands (`<leader>f*`)
```lua
<leader>fc  → FindCommand (show commands palette)
<leader>fo  → FindFolder (open folder)
<leader>fs  → FindSymbol (find symbol)
<leader>ff  → FindFile (quick open files)
<leader>fr  → FindRecent (recent files)
<leader>fw  → FindWord (find in files)
<leader>fe  → FindEmoji
<leader>fp  → FindGitProject (projects)
<leader>fP  → RefreshGitProjectList
<leader>fg  → LiveGrep (search in files)
```

### No Ctrl Keys in VSCode Neovim
You don't use `Ctrl+e` or `Ctrl+b` in Neovim-VSCode mode - you rely on `<leader>f*` mappings.

---

## Recommended Neovim Keybinding Strategy

### File Explorer
```lua
-- Match VSCode behavior:
Ctrl+b  → Toggle Snacks file explorer (like VSCode sidebar toggle)
Ctrl+e  → Focus Snacks file explorer (like VSCode focus explorer)

-- Or keep Vim-friendly (NO Ctrl conflicts):
-           → Oil.nvim (in current directory)
<leader>e   → Toggle Snacks file explorer
<leader>E   → Focus Snacks file explorer
<leader>pv  → Snacks explorer (alt - like :Explore)
```

**Recommendation:** **AVOID Ctrl+e/b** - they conflict with Vim scroll commands
- `Ctrl+e` = scroll window down (useful!)
- `Ctrl+b` = scroll page up (useful!)

**Better approach:**
```lua
-           → Oil.nvim (already decided)
<leader>e   → Snacks explorer toggle
<leader>pv  → Snacks explorer (alt)
```

### Picker/Find Files
```lua
-- Keep LazyVim default for quick access:
<leader><space>  → Quick find files (LazyVim default)

-- Port ALL your <leader>f* muscle memory:
<leader>ff  → Find files (Snacks picker)
<leader>fg  → Live grep (find text)
<leader>fb  → Find buffers
<leader>fr  → Recent files
<leader>fc  → Commands
<leader>fs  → Symbols
<leader>fk  → Keymaps
<leader>fh  → Help tags
... (all your other <leader>f* mappings)
```

**Why this works:**
- `<leader><space>` for quick files (new habit, fast)
- `<leader>f*` for specific searches (muscle memory preserved)
- No Ctrl conflicts with Vim defaults

### Terminal
```lua
-- Match VSCode:
Ctrl+t   → Toggle terminal
Ctrl+/   → Also toggle terminal (LazyVim default, keep as alt)
<C-;>    → Exit terminal mode (already decided)
```

**Tag stack conflict?** NO - you use LSP, not ctags. `Ctrl+t` is free.

### Window Navigation (Neovim only, not VSCode)
```lua
-- You use <leader>m* in old config:
<leader>mh  → Go to left window
<leader>mj  → Go to lower window
<leader>mk  → Go to upper window
<leader>ml  → Go to right window

-- Or switch to LazyVim default (more ergonomic):
Ctrl+h  → Go to left window
Ctrl+j  → Go to lower window
Ctrl+k  → Go to upper window
Ctrl+l  → Go to right window
```

**Recommendation:** Use `Ctrl+h/j/k/l` (LazyVim default, more ergonomic)

---

## Final Keybinding Decisions

### Phase 1 (No keybindings needed)
- Just language setup

### Phase 2 Keybindings

#### File Explorer
```lua
-           → Oil.nvim (CONFIRMED)
<leader>e   → Snacks explorer toggle (NEW)
<leader>pv  → Snacks explorer alt (CONFIRMED)
```

#### Picker/Find
```lua
<leader><space>  → Quick find files (LazyVim default - KEEP)

-- Port from old config:
<leader>ff  → Find files
<leader>fg  → Live grep
<leader>fb  → Find buffers
<leader>fr  → Recent files
<leader>fc  → Commands
<leader>fk  → Keymaps
<leader>fh  → Help tags
<leader>fs  → Symbols (LSP)
<leader>fG  → Grep word under cursor

-- Add more as needed
```

#### Terminal
```lua
Ctrl+t   → Toggle terminal (CONFIRMED - no tag conflict)
<C-;>    → Exit terminal mode (CONFIRMED)
Ctrl+/   → Also toggle (LazyVim default, keep as alt)
```

#### Window Navigation (Neovim)
```lua
-- DECISION NEEDED: <leader>m* or Ctrl+h/j/k/l?

Option A (Your old way):
<leader>mh/j/k/l  → Navigate windows

Option B (LazyVim default, recommended):
Ctrl+h/j/k/l  → Navigate windows
```

---

## VSCode Integration (Phase 5)

Keep all your `<leader>f*` mappings in VSCode mode:
```lua
if vim.g.vscode then
  <leader>ff  → VSCode quick open
  <leader>fg  → VSCode live grep
  <leader>fc  → VSCode command palette
  <leader>fs  → VSCode symbols
  -- etc... (port all 22 VSCode keymap modules)
end
```

---

## Questions to Answer Before Phase 2

### 1. File Explorer Keybinding
- [ ] **Option A**: Keep `-` only for Oil, `<leader>e` for Snacks
- [ ] **Option B**: Use `Ctrl+e` (conflicts with scroll down)
- [ ] **Option C**: Different binding?

**My vote:** Option A (`-` and `<leader>e`)

### 2. Window Navigation in Neovim
- [ ] **Option A**: Keep `<leader>mh/j/k/l` (your old way)
- [ ] **Option B**: Use `Ctrl+h/j/k/l` (LazyVim default, more ergonomic)

**My vote:** Option B (`Ctrl+h/j/k/l` - matches VSCode and is faster)

### 3. All `<leader>f*` Pickers
- [ ] Port all from telescope to snacks picker?
- [ ] Start with just `ff`, `fg`, `fb` and add more as needed?

**My vote:** Port the most used ones first (ff, fg, fb, fr, fc, fk)

---

## Implementation Priority

**Immediate (Phase 2):**
1. `-` for Oil ✅
2. `<leader>e` for Snacks explorer
3. `Ctrl+t` for terminal
4. `<leader>ff/fg/fb` for pickers

**Soon After:**
5. `Ctrl+h/j/k/l` for window nav (or keep `<leader>m*`)
6. More `<leader>f*` pickers as needed

**Later (Phase 4):**
7. All remaining `<leader>f*` mappings
8. Custom keymaps review

---

## Summary

**DON'T use `Ctrl+e/b`** - they conflict with useful Vim scrolling.

**DO use:**
- `-` for Oil
- `<leader>e` for Snacks explorer  
- `<leader>f*` for all your picker commands (muscle memory)
- `Ctrl+t` for terminal (no conflict)
- Consider `Ctrl+h/j/k/l` for windows (more ergonomic than `<leader>m*`)

**This gives you:**
- ✅ VSCode parity where it matters (`<leader>f*` commands)
- ✅ No conflicts with Vim defaults
- ✅ Muscle memory preserved
- ✅ LazyVim defaults where they're better
