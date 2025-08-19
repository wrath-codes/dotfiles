-- Markdown Commands
function MardownPreview()
	VSCodeNotify("markdown.showPreview")
end

function MarkdownToggleBold()
	VSCodeNotify("markdown.extension.editing.toggleBold")
end

function MarkdownToggleItalic()
	VSCodeNotify("markdown.extension.editing.toggleItalic")
end

function MarkdownToggleCodeBlock()
	VSCodeNotify("markdown.extension.editing.toggleCodeBlock")
end

function MarkdownToggleList()
	VSCodeNotify("markdown.extension.editing.toggleList")
end

function MarkdownCreateTableOfContents()
	VSCodeNotify("markdown.extension.toc.create")
end

function MarkdownLinkToFile()
	VSCodeNotify("markdown.editor.insertLinkFromWorkspace")
end

function MarkdownLinkToImage()
	VSCodeNotify("markdown.editor.insertImageFromWorkspace")
end

function MarkdownLintFile()
	VSCodeNotify("markdownlint.fixAll")
end
