-- Settings Commands
function OpenSettings()
	VSCodeNotify("workbench.action.openSettings")
end

function OpenSettingsJSON()
	VSCodeNotify("workbench.action.openSettingsJson")
end

function OpenKeybindings()
	VSCodeNotify("workbench.action.openGlobalKeybindings")
end

function OpenKeybindingsJSON()
	VSCodeNotify("workbench.action.openGlobalKeybindingsFile")
end
