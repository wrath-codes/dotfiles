-- Harpoon Commands
function HarpoonAdd()
	VSCodeNotify("vscode-harpoon.addGlobalEditor")
end

function HarpoonQuickMenu()
	VSCodeNotify("vscode-harpoon.editGlobalEditors")
end

function HarpoonNextPick()
	VSCodeNotify("vscode-harpoon.goToNextGlabalHarpoonEditor")
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
