# VSCode vs Current Neovim Keymaps - Comparison

## Summary of Your VSCode Keymaps (22 modules)

### 1. **Editing** (`editing.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>fae` | Find and Replace | ❌ Missing (use `<leader>sr` in LazyVim) |
| `<leader>frn` | Rename | ✅ Have `<leader>cr` |
| `<leader>frf` | Refactor | ❌ Missing |
| `<leader>fax` | Auto Fix | ❌ Missing |
| `<leader>.` | Quick Fix | ✅ Have it! |
| `za` | Toggle Fold | ✅ Vim default |
| `zR` | Fold All | ✅ Vim default |
| `zM` | Unfold All | ✅ Vim default |
| `<leader>fl` | Open Link | ❌ Missing |
| `gt` | Go to Type Definition | ✅ Have `gy` |
| `gs` | Open Definition to Side | ❌ Missing (now Flash) |
| `gi` | Go to Implementation | ✅ Have `gI` |

---

### 2. **Find** (`find.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>fc` | Find Command | ✅ Have `<leader>sC` |
| `<leader>fo` | Find Folder | ❌ N/A (Neovim doesn't need) |
| `<leader>fs` | Find Symbol | ✅ Have `<leader>ss` |
| `<leader>ff` | Find File | ✅ Have `<leader>ff` |
| `<leader>fr` | Find Recent | ✅ Have `<leader>fr` |
| `<leader>fw` | Find Word | ✅ Have `<leader>sw` |
| `<leader>fe` | Find Emoji | ❌ Missing (VSCode specific) |
| `<leader>fp` | Find Git Project | ✅ Have `<leader>fp` |
| `<leader>fP` | Refresh Git Projects | ❌ N/A |
| `<leader>fg` | Live Grep | ✅ Have `<leader>/` or `<leader>sg` |

**Status:** ✅ Mostly covered

---

### 3. **Formatting** (`formatting.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>fif` | Format File | ✅ Have `<leader>cf` |
| `<leader>fis` | Format Selection | ✅ Have `<leader>cf` (works in visual) |
| `<leader>fus` | Indent Using Spaces | ❌ Missing (rarely needed?) |
| `<leader>fut` | Indent Using Tabs | ❌ Missing (rarely needed?) |

**Status:** ✅ Core functionality covered

---

### 4. **Git** (`git.lua`) - 33 mappings!
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>gin` | Git Init | ❌ Missing |
| `<leader>gst` | Git Status | ✅ Have `<leader>gs` |
| `<leader>gcl` | Git Clone | ❌ Missing (terminal command) |
| `<leader>gpl` | Git Pull | ❌ Missing (use LazyGit) |
| `<leader>gps` | Git Push | ❌ Missing (use LazyGit) |
| `<leader>gfc` | Git Fetch | ❌ Missing (use LazyGit) |
| `<leader>gsa` | Git Stage All | ❌ Missing (use LazyGit) |
| `<leader>gua` | Git Unstage All | ❌ Missing (use LazyGit) |
| `<leader>gsf` | Git Stage File | ❌ Missing (use LazyGit) |
| `<leader>guf` | Git Unstage File | ❌ Missing (use LazyGit) |
| `<leader>gbc` | Git Branch Create | ❌ Missing (use LazyGit) |
| `<leader>gbd` | Git Branch Delete | ❌ Missing (use LazyGit) |
| `<leader>gco` | Git Checkout | ❌ Missing (use LazyGit) |
| `<leader>gcm` | Git Commit | ❌ Missing (use LazyGit) |
| `<leader>ggs` | Git Graph | ❌ Missing |
| ... and 18 more git commands |

**Status:** ⚠️ **Git workflow relies on LazyGit now** (not individual commands)

---

### 5. **Python** (`python.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>prf` | Python Run File | ❌ Missing (use `:!python %`) |
| `<leader>prs` | Python Run Selection | ❌ Missing |
| `<leader>psi` | Python Set Interpreter | ✅ Have `<leader>cv` (venv selector) |
| `<leader>psl` | Python Set Linter | ❌ Missing (configured in Mason) |
| `<leader>psr` | Python Restart LS | ✅ Have `:LspRestart` |

**Status:** ⚠️ Run commands missing, but you can use terminal

---

### 6. **Editor** (`editor.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<Tab>` | Next Editor | ✅ Have (we use for buffer) |
| `<S-Tab>` | Previous Editor | ✅ Have (we use for buffer) |
| `<leader>tl` | Move Editor Left | ❌ Missing |
| `<leader>tr` | Move Editor Right | ❌ Missing |
| `<leader>wc` | Close Editor | ✅ Have `<leader>bd` |
| `<leader>wg` | Close Editor Group | ❌ N/A |
| `<leader>wa` | Close All Editors | ❌ Missing |
| `<leader>wo` | Close Other Editors | ✅ Have `<leader>bo` |
| `<leader>wl` | Close Editors to Left | ❌ Missing |
| `<leader>wr` | Close Editors to Right | ❌ Missing |

**Status:** ⚠️ Some window management missing

---

### 7. **Window** (`window.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>ww` | Close Window | ❌ N/A (VSCode specific) |
| `<leader>wn` | New Window | ❌ N/A |
| `<leader>wR` | Reload Window | ❌ N/A |

**Status:** ✅ Not needed in Neovim

---

### 8. **Toggle** (`toggle.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>tbm` | Toggle Menu Bar | ❌ N/A |
| `<leader>tba` | Toggle Activity Bar | ❌ N/A |
| `<leader>tbs` | Toggle Status Bar | ❌ N/A |
| `<leader>tfs` | Toggle Full Screen | ❌ N/A |
| `<leader>tzm` | Toggle Zen Mode | ✅ Have `<leader>uz` |
| `<leader>iho/O/t` | Inlay Hints | ✅ Have `<leader>uh` |

**Status:** ✅ Mostly N/A or covered

---

### 9. **Harpoon** (`harpoon.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>ha` | Harpoon Add | ✅ Have it! |
| `<leader>hd` | Harpoon Next | ⚠️ You have `<C-S-N>` |
| `<leader>h-` | Harpoon Prev | ⚠️ You have `<C-S-P>` |
| `<leader>he` | Harpoon Edit | ✅ Have it! |
| `<leader>hh/t/n/s` | Marks 1-4 | ✅ You have `1/2/3/4/7/8/9/0` |

**Status:** ✅ Covered (different keymaps but same functionality)

---

### 10. **Notifications** (`notifications.lua`)
| VSCode Keymap | Function | Neovim Equivalent? |
|---------------|----------|-------------------|
| `<leader>nt` | Notifications Toggle | ✅ Have `<leader>n` |
| `<leader>nc` | Notifications Clear | ✅ Have `<leader>un` |
| `<leader>nd` | Notifications Dismiss | ✅ Have `<leader>un` |
| `<leader>no` | Do Not Disturb | ❌ Missing |

**Status:** ✅ Mostly covered

---

### Other Modules (11 more):
- **Theme** - N/A for Neovim
- **Settings** - N/A
- **Extensions** - N/A
- **Java** - Language-specific (if you use Java)
- **Remote** - VSCode specific
- **Server** - VSCode specific
- **Markdown** - Covered by markdown extra
- **SQL** - Database specific
- **REST** - Need kulala or similar
- **JJ** (Jujutsu) - Version control tool
- **Oil** - ✅ Already have Oil.nvim

---

## Critical Missing Features in Current Neovim Config

### 🔴 HIGH PRIORITY (Should Add)
1. **Find and Replace** - `<leader>fae`
   - LazyVim has: `<leader>sr` (grug-far)
   - **Action:** Maybe remap to `<leader>fae` for muscle memory?

2. **Git Individual Commands** - You had 33!
   - **Current:** Using LazyGit for everything
   - **Question:** Do you miss individual git commands or is LazyGit enough?

### 🟡 MEDIUM PRIORITY (Maybe Add)
3. **Python Run File** - `<leader>prf`
   - **Action:** Can add terminal command or use `:!python %`

4. **Refactor** - `<leader>frf`
   - **Action:** Check if LSP code actions cover this

5. **Auto Fix** - `<leader>fax`
   - **Action:** Check if LSP code actions cover this

### 🟢 LOW PRIORITY (Probably Don't Need)
- Format using spaces/tabs (handled by formatters)
- VSCode window management (N/A)
- VSCode UI toggles (N/A)
- Remote/Server commands (VSCode specific)

---

## Recommendations

### Immediate Adds (If You Want):

**1. Find and Replace:**
```lua
-- In keymaps.lua
map("n", "<leader>fae", function() require("grug-far").open() end, { desc = "Find and Replace" })
```

**2. Python Run File:**
```lua
-- In keymaps.lua (Python files only)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<leader>prf", ":!python %<CR>", { desc = "Run Python File", buffer = true })
  end,
})
```

**3. LSP Refactor/Auto Fix:**
Check if `<leader>.` (code actions) covers your refactor/autofix needs.

---

## Questions for You:

1. **Find and Replace** - Do you use grug-far (`<leader>sr`) or do you want `<leader>fae` mapped?

2. **Git Commands** - Are you happy with LazyGit or do you miss individual git command keymaps?

3. **Python Run** - Do you need `<leader>prf` to run Python files, or do you use terminal/debug?

4. **Refactor/AutoFix** - Are LSP code actions (`<leader>.`) enough or do you need separate refactor commands?

Let me know what's missing that you actually use!
