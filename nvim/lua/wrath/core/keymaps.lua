-- set leader key to space
vim.g.mapleader = " "

local jopts = {noremap = true, silent = true}
---------------------
-- General KeyMaps -------------------

-- use jk to exit insert mode
Map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
Map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
Map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
Map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- VIM COMMANDS
-- Clear search with <esc>
Map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>")

Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
Map("x", "J", ":move '>+1<CR>gv-gv")
Map("x", "K", ":move '<-2<CR>gv-gv")

if vim.g.vscode then
    -- VSCode extension
-- VSCODE KEYBINDINGS
-- Commands Related to Find
-- Find Commands (Ctrl+Shift+P)
Map('n', '<leader>fc', function()
    vim.fn.VSCodeNotify('workbench.action.showCommands')
end)
-- Open Folder (Ctrl+K Ctrl+O)
Map('n', '<leader>fo', function()
    vim.fn.VSCodeNotify('workbench.action.files.openFolder')
end)

-- Find Project Files (Ctrl+Shift+E)
Map('n', '<leader>fp', function()
    vim.fn.VSCodeNotify('workbench.action.showAllSymbols')
end)
-- Find All Recent Projects (Ctrl+Shift+R)
Map('n', '<leader>fr', function()
    vim.fn.VSCodeNotify('workbench.action.quickOpenRecent')
end)
-- Find Word in Files (Ctrl+Shift+F)
Map('n', '<leader>fw', function()
    vim.fn.VSCodeNotify('actions.find')
end)
-- Find File (Ctrl+P)
Map('n', '<leader>ff', function()
    vim.fn.VSCodeNotify('workbench.action.quickOpen')
end)
-- Find and Replace (Ctrl+H)
Map('n', '<leader>re', function()
    vim.fn.VSCodeNotify('editor.action.startFindReplaceAction')
end)
--  Find Emoji
Map('n', '<leader>fe', function()
    vim.fn.VSCodeNotify('emoji.insert')
end)
-- Find Git Projects
Map('n', '<leader>fgp', function()
    vim.fn.VSCodeNotify('projectManager.listProjects')
end)
-- Refresh Git Projects
Map('n', '<leader>fgr', function()
    vim.fn.VSCodeNotify('projectManager.refreshGitProjects')
end)

-- Commands Related to Editors
-- Next Editor
Map('n', '<leader>tn', function()
    vim.fn.VSCodeNotify('workbench.action.nextEditorInGroup')
end)
-- Previous Editokr
Map('n', '<leader>tp', function()
    vim.fn.VSCodeNotify('workbench.action.previousEditorInGroup')
end)
-- Move Editor Left
Map('n', '<leader>tl', function()
    vim.fn.VSCodeNotify('workbench.action.moveEditorLeftInGroup')
end)
-- Move Editor Right
Map('n', '<leader>tr', function()
    vim.fn.VSCodeNotify('workbench.action.moveEditorRightInGroup')
end)
-- Tab Editor
Map('n', '<Tab>', function()
    vim.fn.VSCodeNotify('workbench.action.nextEditorInGroup')
end)
-- Shift Tab Editor
Map('n', '<S-Tab>', function()
    vim.fn.VSCodeNotify('workbench.action.previousEditorInGroup')
end)
-- Close Editor
Map('n', '<leader>wc', function()
    vim.fn.VSCodeNotify('workbench.action.closeActiveEditor')
end)
-- Close Editor Group
Map('n', '<leader>wg', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsInGroup')
end)
-- Close All Editors
Map('n', '<leader>wa', function()
    vim.fn.VSCodeNotify('workbench.action.closeAllEditors')
end)
-- Close Other Editors
Map('n', '<leader>wo', function()
    vim.fn.VSCodeNotify('workbench.action.closeOtherEditors')
end)
-- Close Editors to the Left in Group
Map('n', '<leader>wl', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsToTheLeft')
end)
-- Close Editors to the Right in Group
Map('n', '<leader>wr', function()
    vim.fn.VSCodeNotify('workbench.action.closeEditorsToTheRight')
end)


-- Miscellanea
-- Toggle Zen Mode
Map('n', '<leader>zm', function()
    vim.fn.VSCodeNotify('workbench.action.toggleZenMode')
end)
-- Quick Fix
Map('n', '<leader>.', function()
    vim.fn.VSCodeNotify('editor.action.quickFix')
end)
-- Advance New File
Map('n', '<leader>anf', function()
    vim.fn.VSCodeNotify('extension.advancedNewFile')
end)
-- Close VSCode
Map('n', '<leader>ww', function()
    vim.fn.VSCodeNotify('workbench.action.closeWindow')
end)
-- New Window
Map('n', '<leader>wn', function()
    vim.fn.VSCodeNotify('workbench.action.newWindow')
end)

-- command related to toggle
-- Toggle Activity Bar
Map('n', '<leader>tba', function()
    vim.fn.VSCodeNotify('workbench.action.toggleActivityBarVisibility')
end)
-- Toggle Menu Bar
Map('n', '<leader>tbm', function()
    vim.fn.VSCodeNotify('workbench.action.toggleMenuBar')
end)
-- Toggle Status Bar
Map('n', '<leader>tbs', function()
    vim.fn.VSCodeNotify('workbench.action.toggleStatusbarVisibility')
end)
-- Toggle Full Screen
Map('n', '<leader>tfs', function()
    vim.fn.VSCodeNotify('workbench.action.toggleFullScreen')
end)
-- Toggle Theme Change
Map('n', '<leader>ttc', function()
    vim.fn.VSCodeNotify('workbench.action.selectTheme')
end)
-- Toggle Icon Theme
Map('n', '<leader>tti', function()
    vim.fn.VSCodeNotify('workbench.action.selectIconTheme')
end)
-- Toggle Python Interpreter
Map('n', '<leader>tpi', function()
    vim.fn.VSCodeNotify('python.setInterpreter')
end)
-- Toggle Python Linter
Map('n', '<leader>tpl', function()
    vim.fn.VSCodeNotify('python.setLinter')
end)
-- Toggle fold
Map('', '<leader>tff', function()
    vim.fn.VSCodeNotify('editor.toggleFold')
end)
-- Toggle Github Copilot
Map('n', '<leader>tgc', function()
    vim.fn.VSCodeNotify('github.copilot.toggleCopilot')
end)

-- Settings Related Commands
-- Open Settings (Ctrl+,)
Map('n', '<leader>sai', function()
    vim.fn.VSCodeNotify('workbench.action.openSettings')
end)
-- Open Keyboard Shortcuts (Ctrl+K Ctrl+S)
Map('n', '<leader>ski', function()
    vim.fn.VSCodeNotify('workbench.action.openGlobalKeybindings')
end)
-- Open Keybindings (Ctrl+K Ctrl+K)
Map('n', '<leader>skf', function()
    vim.fn.VSCodeNotify('workbench.action.openGlobalKeybindingsFile')
end)
-- Open Application Settings (Ctrl+K Ctrl+O)
Map('n', '<leader>saf', function()
    vim.fn.VSCodeNotify('workbench.action.openApplicationSettingsJson')
end)
-- Ident Using Spaces
Map('n', '<leader>ius', function()
    vim.fn.VSCodeNotify('editor.action.indentUsingSpaces')
end)
-- Ident Using Tabs
Map('n', '<leader>iut', function()
    vim.fn.VSCodeNotify('editor.action.indentUsingTabs')
end)
-- Format Document
Map('n', '<leader>if', function()
    vim.fn.VSCodeNotify('editor.action.formatDocument')
end)
-- Format Selection
Map('v', '<leader>is', function()
    vim.fn.VSCodeNotify('editor.action.formatSelection')
end)
-- Organize Imports
Map('n', '<leader>io', function()
    vim.fn.VSCodeNotify('organize-imports.organizeImports')
end)
-- Definition and Declaration Related Commands
-- Show Hover
Map('n', 'gh', function()
    vim.fn.VSCodeNotify('editor.action.showHover')
end)
Map('n', 'K', function()
    vim.fn.VSCodeNotify('editor.action.showHover')
end)
-- Go to Definition
Map('n', 'gd', function()
    vim.fn.VSCodeNotify('editor.action.revealDefinition')
end)
-- Go to Definition to the Side
Map('n', 'gs', function()
    vim.fn.VSCodeNotify('editor.action.revealDefinitionAside')
end)
-- Peek Definition
Map('n', 'gD', function()
    vim.fn.VSCodeNotify('editor.action.peekDefinition')
end)
-- Reveal Declaration
Map('n', 'gf', function()
    vim.fn.VSCodeNotify('editor.action.revealDeclaration')
end)
-- Peek Declaration
Map('n', 'gF', function()
    vim.fn.VSCodeNotify('editor.action.peekDeclaration')
end)

-- Reference Search
Map('n', 'gH', function()
    vim.fn.VSCodeNotify('editor.action.referenceSearch.trigger')
end)
-- Go to Symbol in File
Map('n', 'gO', function()
    vim.fn.VSCodeNotify('workbench.action.gotoSymbol')
end)

-- Git Commands
-- Add All Modified Files
Map('n', '<leader>gaa', function()
    vim.fn.VSCodeNotify('giteasy.doAddAll')
end)
-- Add current file
Map('n', '<leader>gac', function()
    vim.fn.VSCodeNotify('giteasy.doAddCurrentFile')
end)
-- Add current Directory
Map('n', '<leader>gad', function()
    vim.fn.VSCodeNotify('giteasy.doAdd')
end)
-- Unstage current file
Map('n', '<leader>guc', function()
    vim.fn.VSCodeNotify('giteasy.doUnstageCurrentFile')
end)
-- Git Init
Map('n', '<leader>gin', function()
    vim.fn.VSCodeNotify('git.init')
end)
-- Git Ignore
Map('n', '<leader>gig', function()
    vim.fn.VSCodeNotify('git.ignore')
end)
-- Git Commit
Map('n', '<leader>gcm', function()
    vim.fn.VSCodeNotify('giteasy.doCommit')
end)
-- create repository
Map('n', '<leader>grc', function()
    vim.fn.VSCodeNotify('github.publish')
end)
-- Git Push Remote
Map('n', '<leader>gpr', function()
    vim.fn.VSCodeNotify('giteasy.doRemoteCurrentPush')
end)
-- Git Push to Origin
Map('n', '<leader>gpo', function()
    vim.fn.VSCodeNotify('giteasy.doOriginCurrentPush')
end)
-- Git Push
Map('n', '<leader>gpu', function()
    vim.fn.VSCodeNotify('git.push')
end)
-- Git Push Force
Map('n', '<leader>gpf', function()
    vim.fn.VSCodeNotify('git.pushForce')
end)
-- Git Pull
Map('n', '<leader>gpl', function()
    vim.fn.VSCodeNotify('giteasy.doOriginCurrentPull')
end)
-- Git Create Branch
Map('n', '<leader>gbc', function()
    vim.fn.VSCodeNotify('giteasy.doCreateBranch')
end)
-- Git Checkout/Change Branch
Map('n', '<leader>gcb', function()
    vim.fn.VSCodeNotify('giteasy.doCheckoutBranch')
end)
-- Git Checkout File
Map('n', '<leader>gcf', function()
    vim.fn.VSCodeNotify('giteasy.doCheckoutCurrentFile')
end)
-- Git Status
Map('n', '<leader>gs', function()
    vim.fn.VSCodeNotify('giteasy.doStatus')
end)
-- Git Log All
Map('n', '<leader>gla', function()
    vim.fn.VSCodeNotify('giteasy.doLogAll')
end)
-- Git Log Current File
Map('n', '<leader>glc', function()
    vim.fn.VSCodeNotify('giteasy.doLogCurrentFile')
end)
-- Git add Remote
Map('n', '<leader>gar', function()
    vim.fn.VSCodeNotify('giteasy.doAddRemote')
end)
-- Git add Origin
Map('n', '<leader>gao', function()
    vim.fn.VSCodeNotify('giteasy.doAddOrigin')
end)
-- Git Sync Rebase
Map('n', '<leader>grs', function()
    vim.fn.VSCodeNotify('git.syncRebase')
end)
-- Git Rebase
Map('n', '<leader>grb', function()
    vim.fn.VSCodeNotify('git.rebase')
end)
-- Git Rebase Pull
Map('n', '<leader>grp', function()
    vim.fn.VSCodeNotify('git.pullRebase')
end)
-- Git Rebase Abort
Map('n', '<leader>gra', function()
    vim.fn.VSCodeNotify('git.rebaseAbort')
end)



-- NPM Commands
-- Add Dependency
Map('n', '<leader>ni', function()
    vim.fn.VSCodeNotify('NpmUtils.install-dependency')
end)
-- Add Dev Dependency
Map('n', '<leader>nd', function()
    vim.fn.VSCodeNotify('NpmUtils.install-dev-dependency')
end)
-- Remove Dependency
Map('n', '<leader>nu', function()
    vim.fn.VSCodeNotify('NpmUtils.uninstall-dependency')
end)
-- Run NPM Script
Map('n', '<leader>nr', function()
    vim.fn.VSCodeNotify('NpmUtils.run-script')
end)

-- Harpoon Commands
-- Add Global Mark
Map('n', '<leader>ha', function()
    vim.fn.VSCodeNotify('vscode-harpoon.addGlobalEditor')
end)
-- Mark Quick Switch
Map('n', '<leader>hp', function()
    vim.fn.VSCodeNotify('vscode-harpoon.editorGlobalQuickPick')
end)
-- Edit Global Marks
Map('n', '<leader>he', function()
    vim.fn.VSCodeNotify('vscode-harpoon.editGlobalEditors')
end)
-- Mark 1
Map('n', '<leader>hh', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor1')
end)
-- Mark 2
Map('n', '<leader>ht', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor2')
end)
-- Mark 3
Map('n', '<leader>hn', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor3')
end)
-- Mark 4
Map('n', '<leader>hs', function()
    vim.fn.VSCodeNotify('vscode-harpoon.gotoGlobalEditor4')
end)


-- File Utils Commands
-- Copy Name
Map('n', '<leader>fnc', function()
    vim.fn.VSCodeNotify('fileutils.copyFileName')
end)
-- Delete File
Map('n', '<leader>fdd', function()
    vim.fn.VSCodeNotify('fileutils.removeFile')
end)
-- Duplicate File
Map('n', '<leader>fdu', function()
    vim.fn.VSCodjeNotify('fileutils.duplicateFile')
end)
-- Move File
Map('n', '<leader>fmv', function()
    vim.fn.VSCodeNotify('fileutils.moveFile')
end)
-- Rename File
Map('n', '<leader>fnn', function()
    vim.fn.VSCodeNotify('fileutils.renameFile')
end)
-- New File at Current Location
Map('n', '<leader>fnf', function()
    vim.fn.VSCodeNotify('fileutils.newFile')
end)
-- New File at Project Root
Map('n', '<leader>fnF', function()
    vim.fn.VSCodeNotify('fileutils.newFileAtRoot')
end)
-- New Folder at Current Location
Map('n', '<leader>fnd', function()
    vim.fn.VSCodeNotify('fileutils.newFolder')
end)
-- New Folder at Project Root
Map('n', '<leader>fnD', function()
    vim.fn.VSCodeNotify('fileutils.newFolderAtRoot')
end)

-- Project Commands
-- run java file
Map('n', '<leader>jrf', function()
    vim.fn.VSCodeNotify('java.debug.runJavaFile')
end)

-- Send keys to vscode
-- Map({ "n", "v" }, "<leader>aw", function()
--     vim.fn.VSCodeNotify('vscode-neovim.ctrl-d')
-- end)
-- Map({ "n", "v" }, "<leader>ab", function()
--     vim.fn.VSCodeNotify('vscode-neovim.ctrl-u')
-- end)

else
    -- ordinary Neovim
    -- window management
    Map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
    Map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
    Map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
    Map("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

    Map("n", "<leader>wn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
    Map("n", "<leader>wc", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
    Map("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
    Map("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
    Map("n", "<leader>ws", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
end

