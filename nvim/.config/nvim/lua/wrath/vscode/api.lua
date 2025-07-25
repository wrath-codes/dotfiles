-- Find Related Commands
function FindCommand()
	VSCodeNotify("workbench.action.showCommands")
end

function FindFolder()
	VSCodeNotify("workbench.action.files.openFolder")
end

function FindRecent()
	VSCodeNotify("workbench.action.quickOpenRecent")
end

function FindSymbol()
	VSCodeNotify("workbench.action.showAllSymbols")
end

function FindFile()
	VSCodeNotify("workbench.action.quickOpen")
end

function FindWord()
	VSCodeNotify("actions.find")
end

function FindEmoji()
	VSCodeNotify("emoji.insert")
end

function FindGitProject()
	VSCodeNotify("projectManager.listProjects")
end

function RefreshGitProjectList()
	VSCodeNotify("projectManager.refreshGitProjects")
end

function LiveGrep()
	VSCodeNotify("livegrep.search")
end

-- Quick Editing Commands
function FindAndReplace()
	VSCodeNotify("editor.action.startFindReplaceAction")
end

function Rename()
	VSCodeNotify("editor.action.rename")
end

function Refactor()
	VSCodeNotify("editor.action.refactor")
end

function AutoFix()
	VSCodeNotify("editor.action.autoFix")
end

function QuickFix()
	VSCodeNotify("editor.action.quickFix")
end

function ToggleFold()
	VSCodeNotify("editor.toggleFold")
end

function FoldAll()
	VSCodeNotify("editor.foldAll")
end

function UnfoldAll()
	VSCodeNotify("editor.unfoldAll")
end

function InlayHintsOn()
	VSCodeUpdateConfig("editor.inlayHints.enabled", "on")
	VSCodeAlert("Inlay hints ENABLED.")
end

function InlayHintsOff()
	VSCodeUpdateConfig("editor.inlayHints.enabled", "off")
	VSCodeAlert("Inlay hints DISABLED.")
end

function ToggleInlayHints()
	local inlayHints = VSCodeGetConfig("editor.inlayHints.enabled")
	if inlayHints == "off" then
		InlayHintsOn()
	else
		InlayHintsOff()
	end
end

function OpenLink()
	VSCodeNotify("editor.action.openLink")
end

function OpenDefinitionToSide()
	VSCodeNotify("editor.action.revealDefinitionAside")
end

function GoToTypeDefinition()
	VSCodeNotify("editor.action.goToTypeDefinition")
end

function GoToImplementation()
	VSCodeNotify("editor.action.goToImplementation")
end

-- Formatting Commands
function FormatFile()
	VSCodeNotify("editor.action.formatDocument")
end

function FormatSelection()
	VSCodeNotify("editor.action.formatSelection")
end

function IdentUsingTabs()
	VSCodeNotify("editor.action.indentUsingTabs")
end

function IdentUsingSpaces()
	VSCodeNotify("editor.action.indentUsingSpaces")
end

-- Editor Commands
function NextEditor()
	VSCodeNotify("workbench.action.nextEditorInGroup")
end

function PreviousEditor()
	VSCodeNotify("workbench.action.previousEditorInGroup")
end

function MoveEditorLeft()
	VSCodeNotify("workbench.action.moveEditorLeftInGroup")
end

function MoveEditorRight()
	VSCodeNotify("workbench.action.moveEditorRightInGroup")
end

function CloseEditor()
	VSCodeNotify("workbench.action.closeActiveEditor")
end

function CloseEditorGroup()
	VSCodeNotify("workbench.action.closeEditorsInGroup")
end

function CloseOtherEditors()
	VSCodeNotify("workbench.action.closeOtherEditors")
end

function CloseEditorsToRight()
	VSCodeNotify("workbench.action.closeEditorsToTheRight")
end

function CloseEditorsToLeft()
	VSCodeNotify("workbench.action.closeEditorsToTheLeft")
end

function CloseAllEditors()
	VSCodeNotify("workbench.action.closeAllEditors")
end

-- Window Commands
function NewWindow()
	VSCodeNotify("workbench.action.newWindow")
end

function CloseWindow()
	VSCodeNotify("workbench.action.closeWindow")
end

function ReloadWindow()
	VSCodeNotify("workbench.action.reloadWindow")
end

-- Notification Commands

function NotificationsToggle()
	VSCodeNotify("notifications.toggleList")
end

function NotificationsDoNotDisturb()
	VSCodeNotify("notifications.toggleDoNotDisturbMode")
end

function NotificationsClear()
	VSCodeNotify("notifications.clearAll")
end

function NotificationsDismiss()
	VSCodeNotify("notifications.hideToasts")
end

-- Toggle Commands
function ToggleFullScreen()
	VSCodeNotify("workbench.action.toggleFullScreen")
end

function ToggleZenMode()
	VSCodeNotify("workbench.action.toggleZenMode")
end

function ToggleActivityBar()
	VSCodeNotify("workbench.action.toggleActivityBarVisibility")
end

function ToggleMenuBar()
	VSCodeNotify("workbench.action.toggleMenuBar")
end

function ToggleStatusBar()
	VSCodeNotify("workbench.action.toggleStatusbarVisibility")
end

-- File Manipulation Commands
function BunnyFileNew()
	VSCodeNotify("filebunny.createFile")
end

function BunnyDirectoryNew()
	VSCodeNotify("filebunny.createFolder")
end

function BunnyPathCopyAbsolute()
	VSCodeNotify("filebunny.copyAbsoluteFilePath")
end

function BunnyPathCopyRelative()
	VSCodeNotify("filebunny.copyRelativeFilePath")
end

function BunnyNameCopyFile()
	VSCodeNotify("filebunny.copyFileName")
end

function BunnyActiveFileDelete()
	VSCodeNotify("filebunny.deleteActiveFile")
end

function BunnyFileDelete()
	VSCodeNotify("filebunny.deleteFile")
end

function BunnyDirectoryDelete()
	VSCodeNotify("filebunny.deleteFolder")
end

function BunnyActiveFileDuplicate()
	VSCodeNotify("filebunny.duplicateActiveFile")
end

function BunnyFileDuplicate()
	VSCodeNotify("filebunny.duplicateFile")
end

function BunnyDirectoryDuplicate()
	VSCodeNotify("filebunny.duplicateFolder")
end

function BunnyActiveFileMove()
	VSCodeNotify("filebunny.moveActiveFile")
end

function BunnyFileMove()
	VSCodeNotify("filebunny.moveFile")
end

function BunnyFileRename()
	VSCodeNotify("filebunny.renameActiveFile")
end

function BunnyFileOpenSimple()
	VSCodeNotify("filebunny.openFile")
end

function BunnyFileOpenAbove()
	VSCodeNotify("filebunny.openFileAbove")
end

function BunnyFileOpenBelow()
	VSCodeNotify("filebunny.openFileBelow")
end

function BunnyFileOpenLeft()
	VSCodeNotify("filebunny.openFileToLeft")
end

function BunnyFileOpenRight()
	VSCodeNotify("filebunny.openFileToRight")
end

function BunnyDirectoryOpen()
	VSCodeNotify("filebunny.openFolder")
end

-- Theme Commands
function ChangeColorTheme()
	VSCodeNotify("workbench.action.selectTheme")
end

function ChangeFileIconTheme()
	VSCodeNotify("workbench.action.selectIconTheme")
end

-- Python Commands
function PythonSetInterpreter()
	VSCodeNotify("python.setInterpreter")
end

function PythonSetLinter()
	VSCodeNotify("python.setLinter")
end

function PythonRunFile()
	VSCodeNotify("python.execInTerminal")
end

function PythonRunSelection()
	VSCodeNotify("python.execSelectionInTerminal")
end

function PythonRestartLS()
	VSCodeNotify("python.restartLanguageServer")
end

-- Java Commands
function JavaRunFile()
	VSCodeNotify("java.debug.runJavaFile")
end

function JavaDebugFile()
	VSCodeNotify("java.debug.debugJavaFile")
end

function JavaTestRun()
	VSCodeNotify("testing.runAtCursor")
end

function JavaTestDebug()
	VSCodeNotify("testing.debugAtCursor")
end

function JavaTestCoverage()
	VSCodeNotify("testing.coverageAtCursor")
end

function JavaSBProjectNewMaven()
	VSCodeNotify("spring.initializr.maven-project")
end

function JavaSBProjectNewGradle()
	VSCodeNotify("spring.initializr.gradle-project")
end

function JavaSBProjectNewRegular()
	VSCodeNotify("spring.initializr.createProject")
end

function JavaMavenAddDependency()
	VSCodeNotify("maven.project.addDependency")
end

function JavaMavenExcludeDependency()
	VSCodeNotify("maven.project.excludeDependency")
end

function JavaMavenFavorites()
	VSCodeNotify("maven.favorites")
end

function JavaMavenHistory()
	VSCodeNotify("maven.goal.history")
end

function JavaMavenCommands()
	VSCodeNotify("maven.goal.execute")
end

function JavaMavenProjectNewArchtype()
	VSCodeNotify("maven.archetype.generate")
end

function JavaNewMenu()
	VSCodeNotify("java.view.package.new")
end

function JavaNewFile()
	VSCodeNotify("java.view.package.newFile")
end

function JavaNewFolder()
	VSCodeNotify("java.view.package.newFolder")
end

function JavaNewPackage()
	VSCodeNotify("java.view.package.newPackage")
end

function JavaNewClass()
	VSCodeNotify("java.view.package.newJavaClass")
end

function JavaNewInterface()
	VSCodeNotify("java.view.package.newJavaInterface")
end

function JavaNewEnum()
	VSCodeNotify("java.view.package.newJavaEnum")
end

function JavaNewAnnotation()
	VSCodeNotify("java.view.package.newJavaAnnotation")
end

function JavaNewRecord()
	VSCodeNotify("java.view.package.newJavaRecord")
end

function JavaNewAbstractClass()
	VSCodeNotify("java.view.package.newJavaAbstractClass")
end

-- Settings Commands
function OpenSettings()
	VSCodeNotify("workbench.action.openSettings")
end

function OpenSettingsJSON()
	VSCodeNotify("workbench.action.openApplicationSettingsJson")
end

function OpenKeybindings()
	VSCodeNotify("workbench.action.openGlobalKeybindings")
end

function OpenKeybindingsJSON()
	VSCodeNotify("workbench.action.openGlobalKeybindingsFile")
end

-- Extensions Commands
function InstallExtension()
	VSCodeNotify("workbench.extensions.action.installExtension")
end

function UpdateExtension()
	VSCodeNotify("workbench.extensions.action.updateAllExtensions")
end

function ShowExtensions()
	VSCodeNotify("workbench.view.extensions")
end

function ShowExtensionsUpdates()
	VSCodeNotify("workbench.views.extensions.searchOutdated.focus")
end

function ShowDisabledExtensions()
	VSCodeNotify("workbench.views.extensions.searchDisabled.focus")
end

-- -- Git Commands
function GitInit()
	VSCodeAlert("Initializing a new Git repository...")
	VSCodeNotify("git.init")
end

function GitIgnore()
	VSCodeAlert("Adding .gitignore file...")
	VSCodeNotify("git.ignore")
end

function GitStatus()
	VSCodeNotify("gitlens.gitCommands.status")
end

function GitClone()
	VSCodeNotify("git.clone")
end

function GitPublish()
	VSCodeAlert("Publishing changes to remote repositories...")
	VSCodeNotify("git.publish")
end

function GitPull()
	VSCodeNotify("gitlens.pullRepositories")
end

function GitFetch()
	VSCodeAlert("Fetching data from remote repositories...")
	VSCodeNotify("gitlens.fetchRepositories")
end

function GitSyncRegular()
	VSCodeAlert("Syncing changes with remote repositories...")
	VSCodeNotify("git.sync")
end

function GitSyncRebase()
	VSCodeAlert("Syncing/rebasing changes with remote repositories...")
	VSCodeNotify("git.syncRebase")
end

function GitPullFromBranch()
	VSCodeNotify("git.pullFrom")
end

function GitPush()
	VSCodeAlert("Pushing changes to remote repositories...")
	VSCodeNotify("git.push")
end

function GitPushToBranch()
	VSCodeNotify("git.pushTo")
end

function GitPushForce()
	VSCodeNotify("git.pushForce")
end

function GitStageCurrentFile()
	VSCodeAlert("Staging current file...")
	VSCodeNotify("giteasy.doAddCurrentFile")
end

function GitStageAll()
	VSCodeAlert("Staging all changes...")
	VSCodeNotify("git.stageAll")
end

function GitUnstageAll()
	VSCodeAlert("Unstaging all changes...")
	VSCodeNotify("git.unstageAll")
end

function GitUnstageCurrentFile()
	VSCodeAlert("Unstaging current file...")
	VSCodeNotify("giteasy.doUnstageCurrentFile")
end

function GitBranchCreate()
	VSCodeNotify("gitlens.gitCommands.branch.create")
end

function GitBranchDelete()
	VSCodeNotify("gitlens.gitCommands.branch.delete")
end

function GitBranchRename()
	VSCodeNotify("gitlens.gitCommands.branch.rename")
end

function GitRemoteAdd()
	VSCodeNotify("gitlens.gitCommands.remote.add")
end

function GitRemoteRemove()
	VSCodeNotify("gitlens.gitCommands.remote.remove")
end

function GitRebase()
	VSCodeNotify("gitlens.gitCommands.rebase")
end

function GitCheckout()
	VSCodeNotify("gitlens.gitCommands.checkout")
end

function GitCherryPick()
	VSCodeNotify("gitlens.gitCommands.cherryPick")
end

function GitMerge()
	VSCodeNotify("gitlens.gitCommands.merge")
end

function GitHistoryRepo()
	VSCodeNotify("gitlens.showQuickRepoHistory")
end

function GitHistoryFile()
	VSCodeNotify("gitlens.showQuickFileHistory")
end

function GitHistoryBranch()
	VSCodeNotify("gitlens.showQuickBranchHistory")
end

function GitCommitSearch()
	VSCodeNotify("gitlens.showCommitSearch")
end

function GitCommitMessage()
	VSCodeNotify("git-commit.commit")
end

function GitGraphShow()
	VSCodeNotify("gitlens.showGraph")
end

-- Harpoon Commands
function HarpoonAdd()
	VSCodeNotify("vscode-harpoon.addGlobalEditor")
end

function HarpoonNextPick()
	VSCodeNotify("vscode-harpoon.editorGlobalQuickPick")
end

function HarpoonPrevPick()
	VSCodeNotify("vscode-harpoon.goToPreviousGlabalHarpoonEditor")
end

function HarpoonEdit()
	VSCodeNotify("vscode-harpoon.editGlobalEditors")
end

function HarpoonMark1()
	VSCodeNotify("vscode-harpoon.gotoGlobalEditor1")
end

function HarpoonMark2()
	VSCodeNotify("vscode-harpoon.gotoGlobalEditor2")
end

function HarpoonMark3()
	VSCodeNotify("vscode-harpoon.gotoGlobalEditor3")
end

function HarpoonMark4()
	VSCodeNotify("vscode-harpoon.gotoGlobalEditor4")
end

-- Rest Client Commands
function RestRequestSend()
	VSCodeNotify("rest-client.request")
end

function RestRequestReRunLast()
	VSCodeNotify("rest-client.rerun-last-request")
end

function RestRequestCancel()
	VSCodeNotify("rest-client.cancel-request")
end

function RestResponseSaveFull()
	VSCodeNotify("rest-client.save-response")
end

function RestResponseSaveBody()
	VSCodeNotify("rest-client.save-response-body")
end

function RestHistoryView()
	VSCodeNotify("rest-client.history")
end

function RestHistoryClear()
	VSCodeNotify("rest-client.clear-history")
end

function RestSwitchEnvironment()
	VSCodeNotify("rest-client.switch-environment")
end

function RestSnippetGenerate()
	VSCodeNotify("rest-client.generate-codesnippet")
end

-- Servers Commands

function ServerPublishFull()
	VSCodeNotify("server.publishFull")
end

function ServerPublishIncremental()
	VSCodeNotify("server.publishIncremental")
end

function ServerAddDeployment()
	VSCodeNotify("server.addDeployment")
end

function ServerRemoveDeployment()
	VSCodeNotify("server.removeDeployment")
end

function ServerStart()
	VSCodeNotify("server.start")
end

function ServerStop()
	VSCodeNotify("server.stop")
end

function ServerRestart()
	VSCodeNotify("server.restart")
end

function ServerTerminate()
	VSCodeNotify("server.terminate")
end

function ServerRemove()
	VSCodeNotify("server.remove")
end

function ServerCreate()
	VSCodeNotify("server.createServer")
end

function ServerAddLocal()
	VSCodeNotify("server.addLocation")
end

-- Markdown Commands
function MardownPreview()
	VSCodeNotify("markdown.showPreview")
end

function MarkdownToggleBold()
	VSCodeNotify("markdown.extension.editing.toggleBold")
end

function MarkdownToggleItalic()
	VSCodeNotify("markdown.extension.editing.toggleItalic")
end

function MarkdownToggleCodeBlock()
	VSCodeNotify("markdown.extension.editing.toggleCodeBlock")
end

function MarkdownToggleList()
	VSCodeNotify("markdown.extension.editing.toggleList")
end

function MarkdownCreateTableOfContents()
	VSCodeNotify("markdown.extension.toc.create")
end

function MarkdownLinkToFile()
	VSCodeNotify("markdown.editor.insertLinkFromWorkspace")
end

function MarkdownLinkToImage()
	VSCodeNotify("markdown.editor.insertImageFromWorkspace")
end

function MarkdownLintFile()
	VSCodeNotify("markdownlint.fixAll")
end

-- Remote Commands
function RemoteFocusTunnels()
	VSCodeNotify("remoteTargets.focus")
end

function RemoteFocusDevContainers()
	VSCodeNotify("targetsContainers.focus")
end

function RemoteFocusRemoteRepos()
	VSCodeNotify("remoteHub.views.workspaceRepositories.focus")
end

function RemoteExplorerRefresh()
	VSCodeNotify("remote-explorer.refresh")
end

-- SQLTools Commands
function SQLToolsConnections()
	VSCodeNotify("sqltoolsViewConnectionExplorer.focus")
end

-- Which-key
-- function WhichKey()
-- 	VSCodeNotify("whichkey.show")
-- end

-- Oil VSCode Commands
function OilOpen()
	VSCodeNotify("oil-code.open")
end

function OilOpenParent()
	VSCodeNotify("oil-code.openParent")
end

function OilOpenCwd()
	VSCodeNotify("oil-code.openCwd")
end

function OilSelect()
	VSCodeNotify("oil-code.select")
end

function OilSelectTab()
	VSCodeNotify("oil-code.selectTab")
end

function OilRefresh()
	VSCodeNotify("oil-code.refresh")
end

function OilCd()
	VSCodeNotify("oil-code.cd")
end

function OilClose()
	VSCodeNotify("oil-code.close")
end


-- JujutsuKeizen VSCode Commands
function JjRefresh()
  VSCodeNotify("jj.refresh")
end

function JjNew()
  VSCodeNotify("jj.new")
end

function JjDescribe()
  VSCodeNotify("jj.describe")
end

function JjGitFetch()
  VSCodeNotify("jj.gitFetch")
end

function JjSquashSelectedRanges()
  VSCodeNotify("jj.squashSelectedRanges")
end

function JjOpenFileEditor()
  VSCodeNotify("jj.openFileEditor")
end

function JjOpenDiffEditor()
  VSCodeNotify("jj.openDiffEditor")
end

function JjOpenParentChange()
  VSCodeNotify("jj.openParentChange")
end

function JjOpenChildChange()
  VSCodeNotify("jj.openChildChange")
end

function JjOperationUndo()
  VSCodeNotify("jj.operationUndo")
end

function JjOperationRestore()
  VSCodeNotify("jj.operationRestore")
end