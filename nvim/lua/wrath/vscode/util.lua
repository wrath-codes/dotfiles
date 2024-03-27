function VSCodeNotify(cmd) require('vscode-neovim').call(cmd) end

function VSCodeMap(key, cmd) Map('n', key, cmd) end

-- Map vscode command non-recursively
function VSCodeMapNR(key, cmd) MapNR('n', key, cmd) end
