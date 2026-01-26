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
	VSCodeNotify("workbench.extensions.action.listOutdatedExtensions")
end

function ShowDisabledExtensions()
	VSCodeNotify("workbench.extensions.action.showDisabledExtensions")
end
