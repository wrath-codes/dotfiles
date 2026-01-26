-- Python Commands
function PythonRunFile()
	VSCodeNotify("python.execInTerminal")
end

function PythonRunSelection()
	VSCodeNotify("python.execSelectionInTerminal")
end

function PythonSetInterpreter()
	VSCodeNotify("python.setInterpreter")
end

function PythonSetLinter()
	VSCodeNotify("python.setLinter")
end

function PythonRestartLS()
	VSCodeNotify("python.restartLanguageServer")
end
