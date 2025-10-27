# Phased Rollout Implementation Plan

**Approach:** Systematic, one phase at a time  
**Timeline:** Urgent but careful - complete each phase before moving to next  
**Philosophy:** Test thoroughly, document learnings, iterate based on feedback

---

## 🎯 Current Status: Planning Complete, Ready to Start

---

## Phase 1: Core Setup & Language Support
**Goal:** Get all languages working with LSP, formatters, linters  
**Time Estimate:** 2-3 hours  
**When:** Start immediately

### 1.1 Language Extras (60 min)

**Task:** Enable all language extras in `lua/config/lazy.lua`

```lua
-- Create/edit: lua/config/lazy.lua
return {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  
  -- Primary Languages
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  
  -- Web Development
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.astro" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  
  -- Data/Config Languages
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.prisma" },
  
  -- Infrastructure
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  
  -- Other Languages
  { import = "lazyvim.plugins.extras.lang.elixir" },
  { import = "lazyvim.plugins.extras.lang.gleam" },
  { import = "lazyvim.plugins.extras.lang.typst" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  
  -- Your custom plugins will go here
  { import = "plugins" },
}
```

**Testing Checklist:**
- [ ] Open a Python file - LSP starts, completions work
- [ ] Open a Rust file - rust-analyzer starts, completions work
- [ ] Test Ruff formatting in Python file
- [ ] Test rustfmt in Rust file
- [ ] Open TypeScript file - vtsls works
- [ ] Open Docker/Terraform/YAML files - syntax highlighting works
- [ ] `:checkhealth` shows no critical errors

**Notes:**
- Mason will auto-install LSPs on first use
- Watch for any errors during `:Lazy sync`
- Document any issues

---

### 1.2 Blink.cmp Completion (15 min)

**Task:** Enable blink completion engine

```lua
-- Add to lua/config/lazy.lua imports:
{ import = "lazyvim.plugins.extras.coding.blink" },
```

**Testing Checklist:**
- [ ] Completions popup appears in insert mode
- [ ] LSP completions work
- [ ] Snippet completions work (if using snippets)
- [ ] Tab/Enter to accept works

---

### 1.3 Formatters & Linters (30 min)

**Task:** Configure Biome, Prettier, ESLint, mypy

**Create:** `lua/plugins/formatting.lua`
```lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Biome for modern JS/TS projects
        javascript = { "biome", "prettier" },
        typescript = { "biome", "prettier" },
        javascriptreact = { "biome", "prettier" },
        typescriptreact = { "biome", "prettier" },
        json = { "biome", "prettier" },
        
        -- Python already configured by python extra (ruff)
        -- But we can add additional formatters here if needed
      },
      -- Try biome first, fall back to prettier if no biome.json
      formatters = {
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
```

**Create:** `lua/plugins/linting.lua`
```lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
        -- ESLint auto-detected by eslint extra if enabled
      },
    },
  },
}
```

**Testing Checklist:**
- [ ] Format a Python file - Ruff runs
- [ ] Lint a Python file - mypy shows errors
- [ ] Format a JS file with biome.json - Biome runs
- [ ] Format a JS file without biome.json - Prettier runs
- [ ] ESLint runs on projects with .eslintrc

**Questions to Answer:**
- [ ] Do we need prettier/eslint extras enabled now, or wait until we hit a legacy project?
- [ ] Should we configure additional Python linters (flake8, etc.)?

---

### 1.4 Colorscheme (5 min)

**Task:** Set Catppuccin Mocha theme

**Edit:** `lua/config/options.lua`
```lua
-- Set colorscheme
vim.g.lazyvim_colorscheme = "catppuccin-mocha"
```

**Testing Checklist:**
- [ ] Restart Neovim - Catppuccin Mocha loads
- [ ] Colors match VSCode appearance
- [ ] Syntax highlighting looks good
- [ ] Transparent background if desired

---

### 1.5 Test Everything (30 min)

**Smoke Test:**
1. Open Python project
2. Edit code, get completions
3. Format with Ruff
4. See diagnostics from LSP
5. Repeat for Rust project
6. Open various file types (TS, Docker, YAML, etc.)

**Document Issues:**
- What doesn't work?
- What's slow?
- What's confusing?

---

## Phase 1 Completion Criteria

✅ **Ready to move to Phase 2 when:**
- [ ] All LSPs install and start correctly
- [ ] Completions work in Python and Rust
- [ ] Formatters run on save
- [ ] Linters show diagnostics
- [ ] Colorscheme matches VSCode
- [ ] No critical errors in `:checkhealth`
- [ ] Can comfortably code for a day

**Estimated Time in Phase 1:** 1-2 days of actual coding

---

## Phase 2: Essential Plugins & UI
**Goal:** Add file navigation, pickers, git tools, dashboard  
**Time Estimate:** 2-3 hours  
**When:** After Phase 1 is stable

### 2.1 Oil.nvim File Explorer (30 min)

**Create:** `lua/plugins/oil.lua`
```lua
return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        timeout_ms = 1000,
        autosave_changes = false,
      },
      constrain_cursor = "editable",
      watch_for_changes = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = true,
      view_options = {
        show_hidden = true,  -- IMPORTANT: Show hidden files by default
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          return conf
        end,
      },
      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      ssh = {
        border = "rounded",
      },
    },
  },
}
```

**Testing:**
- [ ] Press `-` - Oil opens
- [ ] See hidden files (`.gitignore`, etc.)
- [ ] Navigate directories
- [ ] Create/delete/rename files
- [ ] Exit back to file

---

### 2.2 Snacks Explorer Keybinding (5 min)

**Edit:** `lua/config/keymaps.lua`
```lua
-- Snacks explorer (backup to Oil)
vim.keymap.set("n", "<leader>pv", function()
  require("snacks").explorer()
end, { desc = "Explorer (Snacks)" })
```

---

### 2.3 Picker Keybindings - DISCUSS FIRST (15 min)

**Options:**

**Option A: Keep LazyVim default**
```lua
-- Already set by LazyVim:
-- <leader><space> for find files
-- <leader>/ for live grep
```

**Option B: VSCode-like (C-p)**
```lua
vim.keymap.set("n", "<C-p>", function()
  require("snacks").picker.files()
end, { desc = "Find Files" })
```

**Option C: User's preference (C-e or C-b)**
```lua
-- C-e (conflicts with scroll down)
vim.keymap.set("n", "<C-e>", function()
  require("snacks").picker.files()
end, { desc = "Find Files" })

-- OR C-b (conflicts with scroll up / tmux)
vim.keymap.set("n", "<C-b>", function()
  require("snacks").picker.files()
end, { desc = "Find Files" })
```

**DECISION NEEDED:**
- [ ] Which keybinding for picker?
- [ ] Do we care about scroll up/down conflicts?
- [ ] Try default first or change immediately?

---

### 2.4 Terminal Keybindings - DISCUSS FIRST (15 min)

**LazyVim Default:**
```lua
-- Already set: <C-/> or <C-_> to toggle terminal
```

**User Preference (VSCode-like):**
```lua
-- C-t to toggle, C-S-t to maximize
vim.keymap.set("n", "<C-t>", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<C-S-t>", function()
  require("snacks").terminal.toggle(nil, { win = { position = "float" } })
end, { desc = "Terminal (float)" })

-- Keep C-; to exit terminal mode
vim.keymap.set("t", "<C-;>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
```

**Conflicts:**
- `C-t` - Vim default: jump to older tag position
- Do we use tag stack?

**DECISION NEEDED:**
- [ ] Map C-t/C-S-t for terminal?
- [ ] Or keep LazyVim's C-/ default?

---

### 2.5 Git Tool - LazyGit (5 min)

**Task:** Test LazyVim's default LazyGit integration

**Keybinding (already set by LazyVim):**
```lua
-- <leader>gg opens LazyGit
```

**Testing:**
- [ ] Press `<leader>gg` - LazyGit opens
- [ ] Stage/unstage files
- [ ] Commit
- [ ] Push/pull
- [ ] View git log
- [ ] Is this workflow good enough?

**Decision Point:**
- [ ] If LazyGit works well → keep it
- [ ] If not → add Neogit in next iteration

---

### 2.6 Dashboard (30 min)

**Create:** `lua/plugins/dashboard.lua`
```lua
return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 █     █░ ██▀███   ▄▄▄      ▄▄▄█████▓ ██░ ██ 
▓█░ █ ░█░▓██ ▒ ██▒▒████▄    ▓  ██▒ ▓▒▓██░ ██▒
▒█░ █ ░█ ▓██ ░▄█ ▒▒██  ▀█▄  ▒ ▓██░ ▒░▒██▀▀██░
░█░ █ ░█ ▒██▀▀█▄  ░██▄▄▄▄██ ░ ▓██▓ ░ ░▓█ ░██ 
░██▒██▓ ░██▓ ▒██▒ ▓█   ▓██▒  ▒██▒ ░ ░▓█▒░██▓ 
░ ▓░▒ ▒  ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░  ▒ ░░    ▒ ░░▒░▒
  ▒ ░ ░    ░▒ ░ ▒░  ▒   ▒▒ ░    ░     ▒ ░▒░ ░
  ░   ░    ░░   ░   ░   ▒     ░       ░  ░░ ░
  ░       ░           ░  ░          ░  ░  ░  
]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          {
            section = "terminal",
            cmd = "echo 'https://github.com/wrath-codes'",
            height = 1,
            padding = 1,
          },
        },
      },
    },
  },
}
```

**Testing:**
- [ ] Open Neovim with no file - Dashboard shows
- [ ] See WRATH ASCII art
- [ ] See GitHub link at bottom
- [ ] Can navigate to recent files

---

### 2.7 Modicator (15 min)

**Create:** `lua/plugins/modicator.lua`
```lua
return {
  {
    "mawkler/modicator.nvim",
    event = "BufEnter",
    opts = {
      show_warnings = false,
      highlights = {
        defaults = {
          bold = true,
          italic = false,
        },
      },
    },
    config = function(_, opts)
      require("modicator").setup(opts)
      
      -- Set cursor line number color
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        callback = function()
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
        end,
      })
    end,
  },
}
```

**Testing:**
- [ ] Cursor line number is blue in normal mode
- [ ] Changes color in insert mode (green)
- [ ] Changes color in visual mode (purple)

---

## Phase 2 Completion Criteria

✅ **Ready to move to Phase 3 when:**
- [ ] Oil opens with `-` and shows hidden files
- [ ] Snacks explorer works with `<leader>pv`
- [ ] Picker keybinding decided and working
- [ ] Terminal keybinding decided and working
- [ ] Git workflow tested (LazyGit or Neogit)
- [ ] Dashboard shows on startup
- [ ] Modicator shows mode colors
- [ ] Can navigate and work comfortably

**Estimated Time in Phase 2:** 1-2 days

---

## Phase 3: Custom Integrations
**When:** After Phase 2 is stable  
**Details:** See MIGRATION_PLAN.md Phase 3

**Key Items:**
- Harpoon 2 with 8 marks (1-4, 7-0)
- Lualine customization (two bars, harpoon tabline, time)
- Navic for breadcrumbs
- Window management

---

## Phase 4: Keymaps Overhaul
**When:** After Phase 3 is stable  
**Details:** See MIGRATION_PLAN.md Phase 4

**Key Items:**
- Remap all `[`/`]` navigation to `<leader>*n/N`
- Core keymaps (select all, clear highlights, etc.)
- Review surround mappings
- Review all LazyVim defaults

---

## Phase 5: VSCode Integration
**When:** After Phase 4 is stable  
**Details:** See MIGRATION_PLAN.md Phase 5

**Key Items:**
- Port VSCode API modules
- Port VSCode keymaps
- Ensure parity between Neovim/VSCode

---

## Phase 6: Polish & Extras
**When:** After Phase 5 is stable  
**Details:** See MIGRATION_PLAN.md Phase 6

**Key Items:**
- Motion plugin (Flash vs Hop)
- Remaining extras
- Plugin cleanup
- Final tweaks

---

## Implementation Guidelines

### Before Starting Each Phase:
1. Review phase goals
2. Understand what success looks like
3. Note current working state (can rollback)
4. Set aside focused time (no distractions)

### During Each Phase:
1. Follow tasks in order
2. Test after each task
3. Document issues immediately
4. Don't skip ahead
5. Take breaks between major tasks

### After Each Phase:
1. Use the config for at least 1-2 days
2. Note what works well
3. Note what's frustrating
4. Document learnings
5. Only then move to next phase

### If Something Breaks:
1. Don't panic
2. Check `:Lazy` for errors
3. Run `:checkhealth`
4. Read error messages carefully
5. Rollback if needed (git is your friend)
6. Ask for help if stuck

---

## Next Immediate Action

**YOU ARE HERE** → Ready to start Phase 1

**First command to run:**
```bash
cd ~/.config/nvim
```

**Then we'll create the files one by one, starting with:**
1. `lua/config/lazy.lua` - Language extras
2. Test that languages work
3. Add blink.cmp
4. Configure formatters/linters
5. Set colorscheme

**Ready to start Phase 1.1?**
