-- Find Related Commands
function FindCommand() VSCodeNotify("workbench.action.showCommands") end

function FindFolder() VSCodeNotify("workbench.action.files.openFolder") end

function FindRecent() VSCodeNotify("workbench.action.quickOpenRecent") end

function FindSymbol() VSCodeNotify("workbench.action.showAllSymbols") end

function FindFile() VSCodeNotify("workbench.action.quickOpen") end

function FindWord() VSCodeNotify("actions.find") end

function FindEmoji() VSCodeNotify("emoji.show") end

function FindGitProject() VSCodeNotify("projectManager.listProjects") end

function RefreshGitProjectList() VSCodeNotify("projectManager.refreshGitProjects") end

-- Quick Editing Commands
function FindAndReplace() VSCodeNotify("editor.action.startFindReplaceAction") end

function Rename() VSCodeNotify("editor.action.rename") end

function Refactor() VSCodeNotify("editor.action.refactor") end

function AutoFix() VSCodeNotify("editor.action.autoFix") end

function QuickFix() VSCodeNotify("editor.action.quickFix") end

function ToggleFold() VSCodeNotify("editor.toggleFold") end

function FoldAll() VSCodeNotify("editor.foldAll") end

function UnfoldAll() VSCodeNotify("editor.unfoldAll") end

function ShowHover() VSCodeNotify("editor.action.showHover") end

function GoToDefinition() VSCodeNotify("editor.action.revealDefinition") end

function GoToDeclaration() VSCodeNotify("editor.action.revealDeclaration") end

function OpenDefinitionToSide() VSCodeNotify("editor.action.revealDefinitionAside") end

function GoToTypeDefinition() VSCodeNotify("editor.action.goToTypeDefinition") end

function GoToImplementation() VSCodeNotify("editor.action.goToImplementation") end

function ReferenceSearch() VSCodeNotify("editor.action.referenceSearch.trigger") end

function GoToSymbol() VSCodeNotify("workbench.action.goToSymbol") end

-- Formatting Commands
function FormatFile() VSCodeNotify("editor.action.formatDocument") end

function FormatSelection() VSCodeNotify("editor.action.formatSelection") end

function IdentUsingTabs() VSCodeNotify("editor.action.indentUsingTabs") end

function IdentUsingSpaces() VSCodeNotify("editor.action.indentUsingSpaces") end

-- Editor Commands
function NextEditor() VSCodeNotify("workbench.action.nextEditorInGroup") end

function PreviousEditor() VSCodeNotify("workbench.action.previousEditorInGroup") end

function MoveEditorLeft() VSCodeNotify("workbench.action.moveEditorLeftInGroup") end

function MoveEditorRight() VSCodeNotify("workbench.action.moveEditorRightInGroup") end

function CloseEditor() VSCodeNotify("workbench.action.closeActiveEditor") end

function CloseEditorGroup() VSCodeNotify("workbench.action.closeEditorsInGroup") end

function CloseOtherEditors() VSCodeNotify("workbench.action.closeOtherEditors") end

function CloseEditorsToRight() VSCodeNotify("workbench.action.closeEditorsToTheRight") end

function CloseEditorsToLeft() VSCodeNotify("workbench.action.closeEditorsToLeft") end

function CloseAllEditors() VSCodeNotify("workbench.action.closeAllEditors") end

-- Window Commands
function NewWindow() VSCodeNotify("workbench.action.newWindow") end

function CloseWindow() VSCodeNotify("workbench.action.closeWindow") end

-- Toggle Commands
function ToggleFullScreen() VSCodeNotify("workbench.action.toggleFullScreen") end

function ToggleZenMode() VSCodeNotify("workbench.action.toggleZenMode") end

function ToggleActivityBar() VSCodeNotify("workbench.action.toggleActivityBarVisibility") end

function ToggleMenuBar() VSCodeNotify("workbench.action.toggleMenuBar") end

function ToggleStatusBar() VSCodeNotify("workbench.action.toggleStatusbarVisibility") end

-- File Manipulation Commands
function AdvancedNewFile() VSCodeNotify("extension.advancedNewFile") end

function CopyFileName() VSCodeNotify("fileutils.copyFileName") end

function DeleteFile() VSCodeNotify("fileutils.removeFile") end

function DuplicateFile() VSCodeNotify("fileutils.duplicateFile") end

function MoveFile() VSCodeNotify("fileutils.moveFile") end

function RenameFile() VSCodeNotify("fileutils.renameFile") end

function NewFileCurrent() VSCodeNotify("fileutils.newFile") end

function NewFileRoot() VSCodeNotify("fileutils.newFileAtRoot") end

function NewDirectoryCurrent() VSCodeNotify("fileutils.newFolder") end

function NewDirectoryRoot() VSCodeNotify("fileutils.newFolderAtRoot") end

-- Theme Commands
function ChangeColorTheme() VSCodeNotify("workbench.action.selectTheme") end

function ChangeFileIconTheme() VSCodeNotify("workbench.action.selectIconTheme") end

-- Python Commands
function PythonSetInterpreter() VSCodeNotify("python.setInterpreter") end

function PythonSetLinter() VSCodeNotify("python.setLinter") end

function PythonRunFile() VSCodeNotify("python.execInTerminal") end

function PythonRunSelection() VSCodeNotify("python.execSelectionInTerminal") end

function PythonRestartLS() VSCodeNotify("python.restartLanguageServer") end

-- Java Commands
function JavaRunFile() VSCodeNotify("java.debug.runJavaFile") end

function JavaDebugFile() VSCodeNotify("java.debug.debugJavaFile") end

function JavaProjectMaven() VSCodeNotify("spring.initializr.maven-project") end

function JavaProjectGradle() VSCodeNotify("spring.initializr.gradle-project") end

function JavaProjectSB() VSCodeNotify("spring.initializr.createProject") end

function JavaMavenAddDependency() VSCodeNotify("maven.project.addDependency") end

function JavaMavenExcludeDependency() VSCodeNotify("maven.project.excludeDependency") end

-- Settings Commands
function OpenSettings() VSCodeNotify("workbench.action.openSettings") end

function OpenSettingsJSON() VSCodeNotify("workbench.action.openApplicationSettingsJson") end

function OpenKeybindings() VSCodeNotify("workbench.action.openGlobalKeybindings") end

function OpenKeybindingsJSON() VSCodeNotify("workbench.action.openGlobalKeybindingsFile") end

-- Extensions Commands
function InstallExtension() VSCodeNotify("workbench.extensions.action.installExtension") end

function UpdateExtension() VSCodeNotify("workbench.extensions.action.updateAllExtensions") end

function ShowExtensions() VSCodeNotify("workbench.view.extensions") end

function ShowExtensionsUpdates() VSCodeNotify("workbench.views.extensions.searchOutdated.focus") end

function ShowDisabledExtensions() VSCodeNotify("workbench.views.extensions.searchDisabled.focus") end

-- Git Commands
function GitInit() VSCodeNotify("git.init") end

function GitIgnore() VSCodeNotify("git.ignore") end

function GitStatus() VSCodeNotify("giteasy.doStatus") end

function GitClone() VSCodeNotify("git.clone") end

function GitPublish() VSCodeNotify("git.publish") end

function GitPull() VSCodeNotify("git.pull") end

function GitPullOrigin() VSCodeNotify("giteasy.doOriginCurrentPull") end

function GitPush() VSCodeNotify("git.push") end

function GitPushForce() VSCodeNotify("git.pushForce") end

function GitPushOrigin() VSCodeNotify("giteasy.doOriginCurrentPush") end

function GitPushRemote() VSCodeNotify("giteasy.doRemoteCurrentPush") end

function GitCommit() VSCodeNotify("giteasy.doCommit") end

function GitCreateBranch() VSCodeNotify("giteasy.doCreateBranch") end

function GitCheckoutBranch() VSCodeNotify("giteasy.doCheckoutBranch") end

function GitCheckoutFile() VSCodeNotify("giteasy.doCheckoutCurrentFile") end

function GitLogCurrent() VSCodeNotify("giteasy.doLogCurrentFile") end

function GitLogAll() VSCodeNotify("giteasy.doLogAll") end

function GitAddRemote() VSCodeNotify("giteasy.doAddRemote") end

function GitAddOrigin() VSCodeNotify("giteasy.doAddOrigin") end

function GitRebase() VSCodeNotify("git.rebase") end

function GitRebasePull() VSCodeNotify("git.pullRebase") end

function GitRebaseAbort() VSCodeNotify("git.rebaseAbort") end

function GitSync() VSCodeNotify("git.syncRebase") end

function GitAddCurrent() VSCodeNotify("giteasy.doAddCurrentFile") end

function GitAddAll() VSCodeNotify("giteasy.doAddAll") end

function GitAddDirectory() VSCodeNotify("giteasy.doAdd") end

function GitUnstageCurrent() VSCodeNotify("giteasy.doUnstageCurrentFile") end

-- Harpoon Commands
function HarpoonAdd() VSCodeNotify("vscode-harpoon.addGlobalEditor") end

function HarpoonNextPick() VSCodeNotify("vscode-harpoon.editorGlobalQuickPick") end

function HarpoonPrevPick() VSCodeNotify("vscode-harpoon.goToPreviousGlabalHarpoonEditor") end

function HarpoonEdit() VSCodeNotify("vscode-harpoon.editGlobalEditors") end

function HarpoonMark1() VSCodeNotify("vscode-harpoon.gotoGlobalEditor1") end

function HarpoonMark2() VSCodeNotify("vscode-harpoon.gotoGlobalEditor2") end

function HarpoonMark3() VSCodeNotify("vscode-harpoon.gotoGlobalEditor3") end

function HarpoonMark4() VSCodeNotify("vscode-harpoon.gotoGlobalEditor4") end