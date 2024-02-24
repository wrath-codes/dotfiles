-- Find Related Commands
function FindCommand() VSCodeNotify("workbench.action.showCommands") end 
function FindFolder() VSCodeNotify("workbench.action.files.openFolder") end
function FindRecent() VSCodeNotify("workbench.action.quickOpenRecent") end
function FindFileProject() VSCodeNotify("workbench.action.showAllSymbols") end
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
function ShowHover() VSCodeNotify("editor.action.showHover") end
function GoToDefinition() VSCodeNotify("editor.action.revealDefinition") end
function GoToDeclaration() VSCodeNotify("editor.action.reviewDeclaration") end
function PeekDefinition() VSCodeNotify("editor.action.peekDefinition") end
function PeekDeclaration() VSCodeNotify("editor.action.peekDeclaration") end
function OpenDefinitionToSide() VSCodeNotify("editor.action.openDefinitionAside") end
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
function MoveEditorLeft () VSCodeNotify("workbench.action.moveEditorLeftInGroup") end
function MoveEditorRight () VSCodeNotify("workbench.action.moveEditorRightInGroup") end
function CloseEditor() VSCodeNotify("workbench.action.closeActiveEditor") end
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
function NewFolder() VSCodeNotify("fileutils.newFolder") end
function NewFolderRoot() VSCodeNotify("fileutils.newFolderAtRoot") end

-- Theme Commands
function ChangeColorTheme() VSCodeNotify("workbench.action.selectTheme") end
function ChangeFileIconTheme() VSCodeNotify("workbench.action.selectIconTheme") end

-- Python Commands
function SetInterpreter() VSCodeNotify("python.setInterpreter") end
function SetLinter() VSCodeNotify("python.setLinter") end

-- Settings Commands
function OpenSettings() VSCodeNotify("workbench.action.openSettings") end
function OpenSettingsJSON() VSCodeNotify("workbench.action.openApplicatioSettingsJson") end
function OpenKeybindings() VSCodeNotify("workbench.action.openGlobalKeybindings") end
function OpenKeybindingsJSON() VSCodeNotify("workbench.action.openGlobalKeybindingsFile") end

-- Extensions Commands
function InstallExtension() VSCodeNotify("workbench.extensions.action.installExtension") end
function UpdateExtension() VSCodeNotify("workbench.extensions.action.updateAllExtensions") end
function ShowExtensions() VSCodeNotify("workbench.view.extensions") end
function ShowExtensionsSearch() VSCodeNotify("workbench.extensions.action.showExtensionsSearch") end
function ShowExtensionsUpdates() VSCodeNotify("workbench.extensions.action.showOutdatedExtensions") end

-- Git Commands
