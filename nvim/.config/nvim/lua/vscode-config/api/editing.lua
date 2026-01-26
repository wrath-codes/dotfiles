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
