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
