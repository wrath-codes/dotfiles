-- Git Commands
function GitInit()
	VSCodeNotify("git.init")
end

function GitIgnore()
	VSCodeNotify("git.ignore")
end

function GitStatus()
	VSCodeNotify("git.status")
end

function GitClone()
	VSCodeNotify("git.clone")
end

function GitPublish()
	VSCodeNotify("git.publish")
end

function GitPull()
	VSCodeNotify("git.pull")
end

function GitPullFromBranch()
	VSCodeNotify("git.pullFrom")
end

function GitPush()
	VSCodeNotify("git.push")
end

function GitFetch()
	VSCodeNotify("git.fetch")
end

function GitSyncRegular()
	VSCodeNotify("git.sync")
end

function GitSyncRebase()
	VSCodeNotify("git.syncRebase")
end

function GitPushToBranch()
	VSCodeNotify("git.pushTo")
end

function GitPushForce()
	VSCodeNotify("git.pushForce")
end

function GitStageAll()
	VSCodeNotify("git.stageAll")
end

function GitUnstageAll()
	VSCodeNotify("git.unstageAll")
end

function GitStageCurrentFile()
	VSCodeNotify("git.stage")
end

function GitUnstageCurrentFile()
	VSCodeNotify("git.unstage")
end

function GitBranchCreate()
	VSCodeNotify("git.branch")
end

function GitBranchDelete()
	VSCodeNotify("git.deleteBranch")
end

function GitBranchRename()
	VSCodeNotify("git.renameBranch")
end

function GitRemoteAdd()
	VSCodeNotify("git.addRemote")
end

function GitRemoteRemove()
	VSCodeNotify("git.removeRemote")
end

function GitRebase()
	VSCodeNotify("git.rebase")
end

function GitCheckout()
	VSCodeNotify("git.checkout")
end

function GitCherryPick()
	VSCodeNotify("git.cherryPick")
end

function GitMerge()
	VSCodeNotify("git.merge")
end

function GitHistoryRepo()
	VSCodeNotify("git.viewHistory")
end

function GitHistoryFile()
	VSCodeNotify("git.viewFileHistory")
end

function GitHistoryBranch()
	VSCodeNotify("git.viewBranchHistory")
end

function GitCommitMessage()
	VSCodeNotify("git.commitWithInput")
end

function GitCommitSearch()
	VSCodeNotify("git.searchCommits")
end

function GitGraphShow()
	VSCodeNotify("git.showGraph")
end
