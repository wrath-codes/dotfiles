-- Find Commands
VSCodeMap('<leader>fc', FindCommand)            -- Find Command
VSCodeMap('<leader>fo', FindFolder)             -- Open Folder
VSCodeMap('<leader>fs', FindSymbol)             -- Find Symbol
VSCodeMap('<leader>ff', FindFile)               -- Find Project Files
VSCodeMap('<leader>fr', FindRecent)             -- Find All Recent Projects
VSCodeMap('<leader>fw', FindWord)               -- Find Word in Files
VSCodeMap('<leader>fe', FindEmoji)              -- Find Emoji
VSCodeMap('<leader>fgp', FindGitProject)        -- Find Git Projects
VSCodeMap('<leader>fgr', RefreshGitProjectList) -- Refresh Git Projects

-- File Util Commands
VSCodeMap('<leader>anf', AdvancedNewFile)     -- Advanced New File
VSCodeMap('<leader>fnf', NewFileCurrent)      -- New File Current
VSCodeMap('<leader>fnd', NewDirectoryCurrent) -- New Directory Current
VSCodeMap('<leader>fnF', NewFileRoot)         -- New File at Root
VSCodeMap('<leader>fnD', NewDirectoryRoot)    -- New Directory at Root
VSCodeMap('<leader>fcn', CopyFileName)        -- Copy File Name
VSCodeMap('<leader>fdl', DeleteFile)          -- Delete File
VSCodeMap('<leader>fdp', DuplicateFile)       -- Duplicate File
VSCodeMap('<leader>frn', RenameFile)          -- Rename File
VSCodeMap('<leader>fmv', MoveFile)            -- Move File

-- Quick Editing Commands
VSCodeMap('<leader>fae', FindAndReplace) -- Find and Replace
VSCodeMap('<leader>frn', Rename)         -- Rename
VSCodeMap('<leader>frf', Refactor)       -- Refactor
VSCodeMap('<leader>fax', AutoFix)        -- Auto Fix
VSCodeMap('<leader>.', QuickFix)         -- Quick Fix
VSCodeMap('<leader>fot', ToggleFold)     -- Toggle Fold
VSCodeMap('<leader>foa', FoldAll)        -- Fold All
VSCodeMap('<leader>fou', UnfoldAll)      -- Unfold All
VSCodeMap('gh', ShowHover)               -- Show Hover
VSCodeMap('gd', GoToDefinition)          -- Go to Definition
VSCodeMap('gD', GoToDeclaration)         -- Go to Declaration
VSCodeMap('gs', OpenDefinitionToSide)    -- Open Definition to the Side
VSCodeMap('gH', ReferenceSearch)         -- Reference Search
VSCodeMap('gS', GoToSymbol)              -- Go to Symbol in File
VSCodeMap('gT', GoToTypeDefinition)      -- Go to Type Definition
VSCodeMap('gI', GoToImplementation)      -- Go to Implementation

-- Formatting Commands
VSCodeMap('<leader>fif', FormatFile)       -- Format File
VSCodeMap('<leader>fis', FormatSelection)  -- Format Selection
VSCodeMap('<leader>fus', IdentUsingSpaces) -- Ident Using Spaces
VSCodeMap('<leader>fut', IdentUsingTabs)   -- Ident Using Tabs

-- Editor Commands
VSCodeMap('<Tab>', NextEditor)               -- Tab Editor
VSCodeMap('<S-Tab>', PreviousEditor)         -- Shift Tab Editor
VSCodeMap('<leader>tl', MoveEditorLeft)      -- Move Editor Left
VSCodeMap('<leader>tr', MoveEditorRight)     -- Move Editor Right
VSCodeMap('<leader>wc', CloseEditor)         -- Close Editor
VSCodeMap('<leader>wg', CloseEditorGroup)    -- Close Editor Group
VSCodeMap('<leader>wa', CloseAllEditors)     -- Close All Editors
VSCodeMap('<leader>wo', CloseOtherEditors)   -- Close Other Editors
VSCodeMap('<leader>wl', CloseEditorsToLeft)  -- Close Editors to the Left in Group
VSCodeMap('<leader>wr', CloseEditorsToRight) -- Close Editors to the Right in Group

-- Window Commands
VSCodeMap('<leader>ww', CloseWindow) -- Close Window
VSCodeMap('<leader>wn', NewWindow)   -- New Window

--  Toggle Commands
VSCodeMap('<leader>tbm', ToggleMenuBar)     -- Toggle Menu Bar
VSCodeMap('<leader>tba', ToggleActivityBar) -- Toggle Activity Bar
VSCodeMap('<leader>tbs', ToggleStatusBar)   -- Toggle Status Bar
VSCodeMap('<leader>tfs', ToggleFullScreen)  -- Toggle Full Screen
VSCodeMap('<leader>tzm', ToggleZenMode)     -- Toggle Zen Mode

-- Theme Commands
VSCodeMap('<leader>ttc', ChangeColorTheme)    -- Toggle Theme Change
VSCodeMap('<leader>tti', ChangeFileIconTheme) -- Toggle Icon Theme

-- Settings Commands
VSCodeMap('<leader>sai', OpenSettings)        -- Open Settings
VSCodeMap('<leader>saf', OpenSettingsJSON)    -- Open Settings JSON
VSCodeMap('<leader>ski', OpenKeybindings)     -- Open Keyboard Shortcuts
VSCodeMap('<leader>skf', OpenKeybindingsJSON) -- Open Keybindings JSON

-- Extensions Commands
VSCodeMap('<leader>ei', InstallExtension)       -- Install Extension
VSCodeMap('<leader>eu', UpdateExtension)        -- Update Extension
VSCodeMap('<leader>es', ShowExtensions)         -- Show Extensions
VSCodeMap('<leader>eo', ShowExtensionsUpdates)  -- Show Extensions Updates
VSCodeMap('<leader>ed', ShowDisabledExtensions) -- Show Extensions Disabled

-- Git Commands
VSCodeMap('<leader>gin', GitInit)            -- Git Init
VSCodeMap('<leader>gig', GitClone)           -- Git Clone
VSCodeMap('<leader>gst', GitStatus)          -- Git Status
VSCodeMap('<leader>gcl', GitClone)           -- Git Clone
VSCodeMap('<leader>gpu', GitPublish)         -- Git Publish
VSCodeMap('<leader>gpl', GitPull)            -- Git Pull
VSCodeMap('<leader>gplo', GitPullOrigin)     -- Git Pull Origin
VSCodeMap('<leader>gpc', GitPush)            -- Git Push
VSCodeMap('<leader>gpo', GitPushOrigin)      -- Git Push Origin
VSCodeMap('<leader>gpr', GitPushRemote)      -- Git Push Remote
VSCodeMap('<leader>gbc', GitCreateBranch)    -- Git Branch Create
VSCodeMap('<leader>gcob', GitCheckoutBranch) -- Git Checkout Branch
VSCodeMap('<leader>gcof', GitCheckoutFile)   -- Git Checkout File
VSCodeMap('<leader>gra', GitAddRemote)       -- Git Add Remote
VSCodeMap('<leader>goa', GitAddOrigin)       -- Git Add Origin
VSCodeMap('<leader>grb', GitRebase)          -- Git Rebase
VSCodeMap('<leader>grp', GitRebasePull)      -- Git Rebase Pull
VSCodeMap('<leader>grA', GitRebaseAbort)     -- Git Rebase Abort
VSCodeMap('<leader>grs', GitSync)            -- Git Sync
VSCodeMap('<leader>gac', GitAddCurrent)      -- Git Add Current
VSCodeMap('<leader>gad', GitAddDirectory)    -- Git Add All
VSCodeMap('<leader>gaa', GitAddAll)          -- Git Add All
VSCodeMap('<leader>guc', GitUnstageCurrent)  -- Git Unstage Current
VSCodeMap('<leader>gcm', GitCommit)          -- Git Commit
VSCodeMap('<leader>glc', GitLogCurrent)      -- Git Log Current
VSCodeMap('<leader>gla', GitLogAll)          -- Git Log All

-- Python Commands
VSCodeMap('<leader>prf', PythonRunFile)        -- Python Run
VSCodeMap('<leader>prs', PythonRunSelection)   -- Python Run Selection
VSCodeMap('<leader>psi', PythonSetInterpreter) -- Python Set Interpreter
VSCodeMap('<leader>psl', PythonSetLinter)      -- Python Set Linter
VSCodeMap('<leader>psr', PythonRestartLS)      -- Python Restart Language Server

-- Java Commands
VSCodeMap('<leader>jrf', JavaRunFile)                -- Java Run File
VSCodeMap('<leader>jdf', JavaDebugFile)              -- Java Debug File
VSCodeMap('<leader>jpm', JavaProjectMaven)           -- Java Project Maven
VSCodeMap('<leader>jpg', JavaProjectGradle)          -- Java Project Gradle
VSCodeMap('<leader>jps', JavaProjectSB)              -- Java Project Spring Boot
VSCodeMap('<leader>jma', JavaMavenAddDependency)     -- Java Maven Add Dependency
VSCodeMap('<leader>jme', JavaMavenExcludeDependency) -- Java Maven Exclude Dependency

-- Harpoon Commands
VSCodeMap('<leader>ha', HarpoonAdd)      -- Harpoon Add
VSCodeMap('<leader>hd', HarpoonNextPick) -- Harpoon Next Pick
VSCodeMap('<leader>h-', HarpoonPrevPick) -- Harpoon Prev Pick
VSCodeMap('<leader>he', HarpoonEdit)     -- Harpoon Edit
VSCodeMap('<leader>hh', HarpoonMark1)    -- Harpoon Mark 1
VSCodeMap('<leader>ht', HarpoonMark2)    -- Harpoon Mark 2
VSCodeMap('<leader>hn', HarpoonMark3)    -- Harpoon Mark 3
VSCodeMap('<leader>hs', HarpoonMark4)    -- Harpoon Mark 4
