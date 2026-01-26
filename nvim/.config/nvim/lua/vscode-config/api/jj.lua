-- JujutsuKeizen VSCode Commands
function JjRefresh()
  VSCodeNotify("jj.refresh")
end

function JjNew()
  VSCodeNotify("jj.new")
end

function JjDescribe()
  VSCodeNotify("jj.describe")
end

function JjGitFetch()
  VSCodeNotify("jj.gitFetch")
end

function JjSquashSelectedRanges()
  VSCodeNotify("jj.squashSelectedRanges")
end

function JjOpenFileEditor()
  VSCodeNotify("jj.openFileEditor")
end

function JjOpenDiffEditor()
  VSCodeNotify("jj.openDiffEditor")
end

function JjOpenParentChange()
  VSCodeNotify("jj.openParentChange")
end

function JjOpenChildChange()
  VSCodeNotify("jj.openChildChange")
end

function JjOperationUndo()
  VSCodeNotify("jj.operationUndo")
end

function JjOperationRestore()
  VSCodeNotify("jj.operationRestore")
end
