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
