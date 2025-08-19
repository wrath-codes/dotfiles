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
