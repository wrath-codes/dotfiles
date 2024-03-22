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
VSCodeMap('<leader>frr', RenameFile)          -- Rename File
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
VSCodeMap('gt', GoToImplementation)      -- Go to Implementation

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
VSCodeMap('<leader>ww', CloseWindow)  -- Close Window
VSCodeMap('<leader>wn', NewWindow)    -- New Window
VSCodeMap('<leader>wR', ReloadWindow) -- Reload Window

-- Navigation Commands
VSCodeMap('<leader>nt', NotificationsToggle)       -- Notifications Toggle
VSCodeMap('<leader>nc', NotificationsClear)        -- Notifications Clear
VSCodeMap('<leader>nd', NotificationsDismiss)      -- Notifications Dismiss
VSCodeMap('<leader>no', NotificationsDoNotDisturb) -- Notifications Do Not Disturb

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
VSCodeMap('<leader>gin', GitInit)               -- Git Init
VSCodeMap('<leader>gig', GitIgnore)             -- Git Ignore
VSCodeMap('<leader>gst', GitStatus)             -- Git Status
VSCodeMap('<leader>gcl', GitClone)              -- Git Clone
VSCodeMap('<leader>gpb', GitPublish)            -- Git Publish
VSCodeMap('<leader>gpl', GitPull)               -- Git Pull
VSCodeMap('<leader>gpL', GitPullFromBranch)     -- Git Pull from Branch
VSCodeMap('<leader>gps', GitPush)               -- Git Push
VSCodeMap('<leader>gpt', GitPushToBranch)       -- Git Push To Branch
VSCodeMap('<leader>gpf', GitPushForce)          -- Git Push Force
VSCodeMap('<leader>gsa', GitStageAll)           -- Git Add All
VSCodeMap('<leader>gua', GitUnstageAll)         -- Git Unstage All
VSCodeMap('<leader>gsf', GitStageCurrentFile)   -- Git Stage Current File
VSCodeMap('<leader>guf', GitUnstageCurrentFile) -- Git Unstage Current File
VSCodeMap('<leader>gbc', GitBranchCreate)       -- Git Branch Create
VSCodeMap('<leader>gbd', GitBranchDelete)       -- Git Branch Delete
VSCodeMap('<leader>gbr', GitBranchRename)       -- Git Branch Rename
VSCodeMap('<leader>gra', GitRemoteAdd)          -- Git Remote Add
VSCodeMap('<leader>grr', GitRemoteRemove)       -- Git Remote Remove
VSCodeMap('<leader>grb', GitRebase)             -- Git Rebase
VSCodeMap('<leader>gco', GitCheckout)           -- Git Checkout
VSCodeMap('<leader>gcp', GitCherryPick)         -- Git Cherry Pick
VSCodeMap('<leader>gmr', GitMerge)              -- Git Merge
VSCodeMap('<leader>ghr', GitHistoryRepo)        -- Git History Repo
VSCodeMap('<leader>ghf', GitHistoryFile)        -- Git History File
VSCodeMap('<leader>ghb', GitHistoryBranch)      -- Git History Branch
VSCodeMap('<leader>gcm', GitCommitMessage)      -- Git Commit Message
VSCodeMap('<leader>gca', GitCommitSearch)       -- Git Commit Search
VSCodeMap('<leader>ggs', GitGraphShow)          -- Git Show Graph

-- Python Commands
VSCodeMap('<leader>prf', PythonRunFile)        -- Python Run
VSCodeMap('<leader>prs', PythonRunSelection)   -- Python Run Selection
VSCodeMap('<leader>psi', PythonSetInterpreter) -- Python Set Interpreter
VSCodeMap('<leader>psl', PythonSetLinter)      -- Python Set Linter
VSCodeMap('<leader>psr', PythonRestartLS)      -- Python Restart Language Server

-- Java Commands
VSCodeMap('<leader>jrf', JavaRunFile)                  -- Java Run File
VSCodeMap('<leader>jrt', JavaTestRun)                  -- Java Run Test
VSCodeMap('<leader>jdf', JavaDebugFile)                -- Java Debug File
VSCodeMap('<leader>jdt', JavaTestDebug)                -- Java Debug Test
VSCodeMap('<leader>jct', JavaTestCoverage)             -- Java Test Coverage
VSCodeMap('<leader>jsm', JavaSBProjectNewMaven)        -- Java Project Maven
VSCodeMap('<leader>jsg', JavaSBProjectNewGradle)       -- Java Project Gradle
VSCodeMap('<leader>jss', JavaSBProjectNewRegular)      -- Java Project Spring Boot
VSCodeMap('<leader>jmad', JavaMavenAddDependency)      -- Java Maven Add Dependency
VSCodeMap('<leader>jmed', JavaMavenExcludeDependency)  -- Java Maven Exclude Dependency
VSCodeMap('<leader>jmna', JavaMavenProjectNewArchtype) -- Java Maven Project New Archtype
VSCodeMap('<leader>jmhr', JavaMavenHistory)            -- Java Maven History
VSCodeMap('<leader>jmcm', JavaMavenCommands)           -- Java Execute Maven Command
VSCodeMap('<leader>jmfv', JavaMavenFavorites)          -- Java Maven Favorites

-- Harpoon Commands
VSCodeMap('<leader>ha', HarpoonAdd)      -- Harpoon Add
VSCodeMap('<leader>hd', HarpoonNextPick) -- Harpoon Next Pick
VSCodeMap('<leader>h-', HarpoonPrevPick) -- Harpoon Prev Pick
VSCodeMap('<leader>he', HarpoonEdit)     -- Harpoon Edit
VSCodeMap('<leader>hh', HarpoonMark1)    -- Harpoon Mark 1
VSCodeMap('<leader>ht', HarpoonMark2)    -- Harpoon Mark 2
VSCodeMap('<leader>hn', HarpoonMark3)    -- Harpoon Mark 3
VSCodeMap('<leader>hs', HarpoonMark4)    -- Harpoon Mark 4

-- Rest Client Commands
VSCodeMap('<leader>rqs', RestRequestSend)       -- Rest Request Send
VSCodeMap('<leader>rql', RestRequestReRunLast)  -- Rest Request ReRun Last
VSCodeMap('<leader>rqc', RestRequestCancel)     -- Rest Request Cancel
VSCodeMap('<leader>rpf', RestResponseSaveFull)  -- Rest Response Save Full
VSCodeMap('<leader>rpb', RestResponseSaveBody)  -- Rest Response Save Body
VSCodeMap('<leader>rhv', RestHistoryView)       -- Rest History View
VSCodeMap('<leader>rhc', RestHistoryClear)      -- Rest History Clear
VSCodeMap('<leader>rse', RestSwitchEnvironment) -- Rest Switch Environment
VSCodeMap('<leader>rsg', RestSnippetGenerate)   -- Rest Snippet Generate

-- Server Commands
VSCodeMap('<leader>sta', ServerStart)              -- Server Start
VSCodeMap('<leader>sto', ServerStop)               -- Server Stop
VSCodeMap('<leader>sre', ServerRestart)            -- Server Restart
VSCodeMap('<leader>sda', ServerAddDeployment)      -- Server Add Deployment
VSCodeMap('<leader>sdr', ServerRemoveDeployment)   -- Server Remove Deployment
VSCodeMap('<leader>spf', ServerPublishFull)        -- Server Publish Full
VSCodeMap('<leader>spi', ServerPublishIncremental) -- Server Publish Incremental
VSCodeMap('<leader>ste', ServerTerminate)          -- Server Terminate
VSCodeMap('<leader>srm', ServerRemove)             -- Server Remove
VSCodeMap('<leader>scr', ServerCreate)             -- Server Create
VSCodeMap('<leader>sla', ServerAddLocal)           -- Server Add Local
