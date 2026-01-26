Map = vim.keymap.set
local vscode = require("vscode")

function VSCodeMap(key, cmd)
	Map("n", key, cmd)
end

function VSCodeNotify(cmd)
	vscode.action(cmd)
end

function VSCodeAlert(message)
	vscode.notify(message)
end

function VSCodeHasConfig(configs)
	return vscode.has_config(configs)
end

function VSCodeGetConfig(config)
	return vscode.get_config(config)
end

function VSCodeUpdateConfig(configs, values)
	vscode.update_config(configs, values, "global")
end
