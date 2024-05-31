Map = vim.keymap.set

function VSCodeNotify(cmd)
	require("vscode-neovim").call(cmd)
end

function VSCodeAlert(message)
	require("vscode-neovim").notify(message)
end

function VSCodeMap(key, cmd)
	Map("n", key, cmd)
end
