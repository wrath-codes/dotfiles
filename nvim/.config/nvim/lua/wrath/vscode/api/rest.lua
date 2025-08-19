-- Rest Client Commands
function RestRequestSend()
	VSCodeNotify("rest-client.request")
end

function RestRequestReRunLast()
	VSCodeNotify("rest-client.rerun-last-request")
end

function RestRequestCancel()
	VSCodeNotify("rest-client.cancel-request")
end

function RestResponseSaveFull()
	VSCodeNotify("rest-client.save-response")
end

function RestResponseSaveBody()
	VSCodeNotify("rest-client.save-response-body")
end

function RestHistoryView()
	VSCodeNotify("rest-client.history")
end

function RestHistoryClear()
	VSCodeNotify("rest-client.clear-history")
end

function RestSwitchEnvironment()
	VSCodeNotify("rest-client.switch-environment")
end

function RestSnippetGenerate()
	VSCodeNotify("rest-client.generate-codesnippet")
end
