-- Formatting Commands
function FormatFile()
	VSCodeNotify("editor.action.formatDocument")
end

function FormatSelection()
	VSCodeNotify("editor.action.formatSelection")
end

function IdentUsingTabs()
	VSCodeNotify("editor.action.indentUsingTabs")
end

function IdentUsingSpaces()
	VSCodeNotify("editor.action.indentUsingSpaces")
end
