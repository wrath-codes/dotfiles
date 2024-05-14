Map = vim.keymap.set

function VSCodeNotify(cmd)
	require("vscode-neovim").call(cmd)
end
function VSCodeMap(key, cmd)
	Map("n", key, cmd)
end