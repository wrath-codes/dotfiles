-- Oil VSCode Commands
function OilOpen()
	VSCodeNotify("oil-code.open")
end

function OilOpenParent()
	VSCodeNotify("oil-code.openParent")
end

function OilOpenCwd()
	VSCodeNotify("oil-code.openCwd")
end

function OilSelect()
	VSCodeNotify("oil-code.select")
end

function OilSelectTab()
	VSCodeNotify("oil-code.selectTab")
end

function OilRefresh()
	VSCodeNotify("oil-code.refresh")
end

function OilCd()
	VSCodeNotify("oil-code.cd")
end

function OilClose()
	VSCodeNotify("oil-code.close")
end
