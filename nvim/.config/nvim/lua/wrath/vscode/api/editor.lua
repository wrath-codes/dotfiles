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
