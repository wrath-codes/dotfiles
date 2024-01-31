-- set leader key to space
vim.g.mapleader = " "

local opts = {noremap = true, silent = true}
local map = vim.keymap.set -- for convenience
---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- VIM COMMANDS
-- Clear search with <esc>
map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>")

map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

if vim.g.vscode then
    -- VSCode extension
-- VSCODE KEYBINDINGS
-- Commands Related to Find
-- Find Commands (Ctrl+Shift+P)
map('n', '<leader>fc', function()
    vim.fn.VSCodeNotify('workbench.action.showCommands')
end)
-- Find Project Files (Ctrl+Shift+E)
map('n', '<leader>fp', function()
    vim.fn.VSCodeNotify('workbench.action.showAllSymbols')
end)
-- Find All Recent Projects (Ctrl+Shift+R)
map('n', '<leader>fr', function()
    vim.fn.VSCodeNotify('workbench.action.quickOpenRecent')
end)
-- Find Word in Files (Ctrl+Shift+F)
map('n', '<leader>fw', function()
    vim.fn.VSCodeNotify('actions.find')
end)
-- Find File (Ctrl+P)
map('n', '<leader>ff', function()
    vim.fn.VSCodeNotify('workbench.action.quickOpen')
end)
-- Find and Replace (Ctrl+H)
map('n', '<leader>re', function()
    vim.fn.VSCodeNotify('editor.action.startFindReplaceAction')
end)
--  Find Emoji
map('n', '<leader>fe', function()
    vim.fn.VSCodeNotify('emoji.insert')
end)
-- Find Git Projects
map('n', '<leader>fgp', function()
    vim.fn.VSCodeNotify('projectManager.listProjects')
end)
-- Refresh Git Projects
map('n', '<leader>fgr', function()
    vim.fn.VSCodeNotify('projectManager.refreshGitProjects')
end)

-- Commands Related to Editors
-- Next Editor
map('n', '<leader>tn', function()
    vim.fn.VSCodeNotify('workbench.action.nextEditorInGroup')
end)
-- Previous Editokr
map('n', '<leader>tp', function()
    vim.fn.VSCodeNotify('workbench.action.previousEditorInGroup')
end)
-- Move Editor Left
map('n', '<leader>tl', function()
    vim.fn.VSCodeNotify('workbench.action.moveEditorLeftInGroup')
end)
-- Move Editor Right
map('n', '<leader>tr', function()
    vim.fn.VSCodeNotify('workbench.action.moveEditorRightInGroup')
end)
-- Tab Editor
map('n', '<Tab>', function()
    vim.fn.VSCodeNotify('workbench.action.nextEditorInGroup')
end)
-- Shift Tab Editor
map('n', '<S-Tab>', function()
    vim.fn.VSCodeNotify('workbench.action.previousEditorInGroup')
end)
-- Close Editor
map('n', '<leader>wc', function()
    vim.fn.VSCodeNotify('workbench.action.closeActiveEditor')
end)
-- Close Editor Group
map('n', '<leader>wg', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsInGroup')
end)
-- Close All Editors
map('n', '<leader>wa', function()
    vim.fn.VSCodeNotify('workbench.action.closeAllEditors')
end)
-- Close Other Editors
map('n', '<leader>wo', function()
    vim.fn.VSCodeNotify('workbench.action.closeOtherEditors')
end)
-- Close Editors to the Left in Group
map('n', '<leader>wl', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsToTheLeft')
end)
-- Close Editors to the Right in Group
map('n', '<leader>wr', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsToTheRight')
end)


-- Miscellanea
-- Toggle Zen Mode
map('n', '<leader>zm', function()
    vim.fn.VSCodeNotify('workbench.action.toggleZenMode')
end)
-- Quick Fix
map('n', '<leader>.', function()
    vim.fn.VSCodeNotify('editor.action.quickFix')
end)
-- Advance New File
map('n', '<leader>anf', function()
    vim.fn.VSCodeNotify('extension.advancedNewFile')
end)
-- Close VSCode
map('n', '<leader>ww', function()
    vim.fn.VSCodeNotify('workbench.action.closeWindow')
end)
-- New Window
map('n', '<leader>wn', function()
    vim.fn.VSCodeNotify('workbench.action.newWindow')
end)

-- command related to toggle
-- Toggle Activity Bar
map('n', '<leader>tba', function()
    vim.fn.VSCodeNotify('workbench.action.toggleActivityBarVisibility')
end)
-- Toggle Menu Bar
map('n', '<leader>tbm', function()
    vim.fn.VSCodeNotify('workbench.action.toggleMenuBar')
end)
-- Toggle Status Bar
map('n', '<leader>tbs', function()
    vim.fn.VSCodeNotify('workbench.action.toggleStatusbarVisibility')
end)
-- Toggle Full Screen
map('n', '<leader>tfs', function()
    vim.fn.VSCodeNotify('workbench.action.toggleFullScreen')
end)
-- Toggle Theme Change
map('n', '<leader>ttc', function()
    vim.fn.VSCodeNotify('workbench.action.selectTheme')
end)
-- Toggle Icon Theme
map('n', '<leader>tti', function()
    vim.fn.VSCodeNotify('workbench.action.selectIconTheme')
end)
-- Toggle Python Interpreter
map('n', '<leader>tpi', function()
    vim.fn.VSCodeNotify('python.setInterpreter')
end)
-- Toggle Python Linter
map('n', '<leader>tpl', function()
    vim.fn.VSCodeNotify('python.setLinter')
end)
-- Toggle fold
map('', '<leader>tff', function()
    vim.fn.VSCodeNotify('editor.toggleFold')
end)
-- Toggle Github Copilot
map('n', '<leader>tgc', function()
    vim.fn.VSCodeNotify('github.copilot.toggleCopilot')
end)

-- Settings Related Commands
-- Open Settings (Ctrl+,)
map('n', '<leader>sai', function()
    vim.fn.VSCodeNotify('workbench.action.openSettings')
end)
-- Open Keyboard Shortcuts (Ctrl+K Ctrl+S)
map('n', '<leader>ski', function()
    vim.fn.VSCodeNotify('workbench.action.openGlobalKeybindings')
end)
-- Open Keybindings (Ctrl+K Ctrl+K)
map('n', '<leader>skf', function()
    vim.fn.VSCodeNotify('workbench.action.openGlobalKeybindingsFile')
end)
-- Open Application Settings (Ctrl+K Ctrl+O)
map('n', '<leader>saf', function()
    vim.fn.VSCodeNotify('workbench.action.openApplicationSettingsJson')
end)
-- Ident Using Spaces
map('n', '<leader>ius', function()
    vim.fn.VSCodeNotify('editor.action.indentUsingSpaces')
end)
-- Ident Using Tabs
map('n', '<leader>iut', function()
    vim.fn.VSCodeNotify('editor.action.indentUsingTabs')
end)
-- Format Document
map('n', '<leader>if', function()
    vim.fn.VSCodeNotify('editor.action.formatDocument')
end)
-- Format Selection
map('v', '<leader>is', function()
    vim.fn.VSCodeNotify('editor.action.formatSelection')
end)
-- Organize Imports
map('n', '<leader>io', function()
    vim.fn.VSCodeNotify('organize-imports.organizeImports')
end)
-- Definition and Declaration Related Commands
-- Show Hover
map('n', 'gh', function()
    vim.fn.VSCodeNotify('editor.action.showHover')
end)
map('n', 'K', function()
    vim.fn.VSCodeNotify('editor.action.showHover')
end)
-- Go to Definition
map('n', 'gd', function()
    vim.fn.VSCodeNotify('editor.action.revealDefinition')
end)
-- Go to Definition to the Side
map('n', 'gs', function()
    vim.fn.VSCodeNotify('editor.action.revealDefinitionAside')
end)
-- Peek Definition
map('n', 'gD', function()
    vim.fn.VSCodeNotify('editor.action.peekDefinition')
end)
-- Reveal Declaration
map('n', 'gf', function()
    vim.fn.VSCodeNotify('editor.action.revealDeclaration')
end)
-- Peek Declaration
map('n', 'gF', function()
    vim.fn.VSCodeNotify('editor.action.peekDeclaration')
end)

-- Reference Search
map('n', 'gH', function()
    vim.fn.VSCodeNotify('editor.action.referenceSearch.trigger')
end)
-- Go to Symbol in File
map('n', 'gO', function()
    vim.fn.VSCodeNotify('workbench.action.gotoSymbol')
end)

-- Git Commands
-- Add All Modified Files
map('n', '<leader>gaa', function()
    vim.fn.VSCodeNotify('giteasy.doAddAll')
end)
-- Add current file
map('n', '<leader>gac', function()
    vim.fn.VSCodeNotify('giteasy.doAddCurrentFile')
end)
-- Add current Directory
map('n', '<leader>gad', function()
    vim.fn.VSCodeNotify('giteasy.doAdd')
end)
-- Unstage current file
map('n', '<leader>guc', function()
    vim.fn.VSCodeNotify('giteasy.doUnstageCurrentFile')
end)
-- Git Init
map('n', '<leader>gin', function()
    vim.fn.VSCodeNotify('git.init')
end)
-- Git Ignore
map('n', '<leader>gig', function()
    vim.fn.VSCodeNotify('git.ignore')
end)
-- Git Commit
map('n', '<leader>gcm', function()
    vim.fn.VSCodeNotify('giteasy.doCommit')
end)
-- create repository
map('n', '<leader>grc', function()
    vim.fn.VSCodeNotify('github.publish')
end)
-- Git Push Remote
map('n', '<leader>gpr', function()
    vim.fn.VSCodeNotify('giteasy.doRemoteCurrentPush')
end)
-- Git Push to Origin
map('n', '<leader>gpo', function()
    vim.fn.VSCodeNotify('giteasy.doOriginCurrentPush')
end)
-- Git Push
map('n', '<leader>gpu', function()
    vim.fn.VSCodeNotify('git.push')
end)
-- Git Push Force
map('n', '<leader>gpf', function()
    vim.fn.VSCodeNotify('git.pushForce')
end)
-- Git Pull
map('n', '<leader>gpl', function()
    vim.fn.VSCodeNotify('giteasy.doOriginCurrentPull')
end)
-- Git Create Branch
map('n', '<leader>gbc', function()
    vim.fn.VSCodeNotify('giteasy.doCreateBranch')
end)
-- Git Checkout/Change Branch
map('n', '<leader>gcb', function()
    vim.fn.VSCodeNotify('giteasy.doCheckoutBranch')
end)
-- Git Checkout File
map('n', '<leader>gcf', function()
    vim.fn.VSCodeNotify('giteasy.doCheckoutCurrentFile')
end)
-- Git Status
map('n', '<leader>gs', function()
    vim.fn.VSCodeNotify('giteasy.doStatus')
end)
-- Git Log All
map('n', '<leader>gla', function()
    vim.fn.VSCodeNotify('giteasy.doLogAll')
end)
-- Git Log Current File
map('n', '<leader>glc', function()
    vim.fn.VSCodeNotify('giteasy.doLogCurrentFile')
end)
-- Git add Remote
map('n', '<leader>gar', function()
    vim.fn.VSCodeNotify('giteasy.doAddRemote')
end)
-- Git add Origin
map('n', '<leader>gao', function()
    vim.fn.VSCodeNotify('giteasy.doAddOrigin')
end)
-- Git Sync Rebase
map('n', '<leader>grs', function()
    vim.fn.VSCodeNotify('git.syncRebase')
end)
-- Git Rebase
map('n', '<leader>grb', function()
    vim.fn.VSCodeNotify('git.rebase')
end)
-- Git Rebase Pull
map('n', '<leader>grp', function()
    vim.fn.VSCodeNotify('git.pullRebase')
end)
-- Git Rebase Abort
map('n', '<leader>gra', function()
    vim.fn.VSCodeNotify('git.rebaseAbort')
end)



-- NPM Commands
-- Add Dependency
map('n', '<leader>ni', function()
    vim.fn.VSCodeNotify('NpmUtils.install-dependency')
end)
-- Add Dev Dependency
map('n', '<leader>nd', function()
    vim.fn.VSCodeNotify('NpmUtils.install-dev-dependency')
end)
-- Remove Dependency
map('n', '<leader>nu', function()
    vim.fn.VSCodeNotify('NpmUtils.uninstall-dependency')
end)
-- Run NPM Script
map('n', '<leader>nr', function()
    vim.fn.VSCodeNotify('NpmUtils.run-script')
end)

-- Harpoon Commands
-- Add Global Mark
map('n', '<leader>ha', function()
    vim.fn.VSCodeNotify('vscode-harpoon.addGlobalEditor')
end)
-- Mark Quick Switch
map('n', '<leader>hp', function()
    vim.fn.VSCodeNotify('vscode-harpoon.editorGlobalQuickPick')
end)
-- Edit Global Marks
map('n', '<leader>he', function()
    vim.fn.VSCodeNotify('vscode-harpoon.editGlobalEditors')
end)
-- Mark 1
map('n', '<leader>hh', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor1')
end)
-- Mark 2
map('n', '<leader>ht', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor2')
end)
-- Mark 3
map('n', '<leader>hn', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor3')
end)
-- Mark 4
map('n', '<leader>hs', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor4')
end)


-- File Utils Commands
-- Copy Name
map('n', '<leader>fnc', function()
    vim.fn.VSCodeNotify('fileutils.copyFileName')
end)
-- Delete File
map('n', '<leader>fdd', function()
    vim.fn.VSCodeNotify('fileutils.removeFile')
end)
-- Duplicate File
map('n', '<leader>fdu', function()
    vim.fn.VSCodjeNotify('fileutils.duplicateFile')
end)
-- Move File
map('n', '<leader>fmv', function()
    vim.fn.VSCodeNotify('fileutils.moveFile')
end)
-- Rename File
map('n', '<leader>fnn', function()
    vim.fn.VSCodeNotify('fileutils.renameFile')
end)
-- New File at Current Location
map('n', '<leader>fnf', function()
    vim.fn.VSCodeNotify('fileutils.newFile')
end)
-- New File at Project Root
map('n', '<leader>fnF', function()
    vim.fn.VSCodeNotify('fileutils.newFileAtRoot')
end)
-- New Folder at Current Location
map('n', '<leader>fnd', function()
    vim.fn.VSCodeNotify('fileutils.newFolder')
end)
-- New Folder at Project Root
map('n', '<leader>fnD', function()
    vim.fn.VSCodeNotify('fileutils.newFolderAtRoot')
end)

-- Project Commands

else
    -- ordinary Neovim
end

