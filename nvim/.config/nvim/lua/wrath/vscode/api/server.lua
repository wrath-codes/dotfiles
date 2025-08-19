-- Servers Commands

function ServerPublishFull()
	VSCodeNotify("server.publishFull")
end

function ServerPublishIncremental()
	VSCodeNotify("server.publishIncremental")
end

function ServerAddDeployment()
	VSCodeNotify("server.addDeployment")
end

function ServerRemoveDeployment()
	VSCodeNotify("server.removeDeployment")
end

function ServerStart()
	VSCodeNotify("server.start")
end

function ServerStop()
	VSCodeNotify("server.stop")
end

function ServerRestart()
	VSCodeNotify("server.restart")
end

function ServerTerminate()
	VSCodeNotify("server.terminate")
end

function ServerRemove()
	VSCodeNotify("server.remove")
end

function ServerCreate()
	VSCodeNotify("server.createServer")
end

function ServerAddLocal()
	VSCodeNotify("server.addLocation")
end
