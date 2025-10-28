local M = {}

M.snippets_cache = nil

-- Parse a snippet file and extract metadata + code
local function parse_snippet_file(filepath)
  local file = io.open(filepath, "r")
  if not file then
    return nil
  end

  local content = file:read("*all")
  file:close()

  -- Extract frontmatter
  local frontmatter = content:match("^%-%-%-\n(.-)\n%-%-%-")
  if not frontmatter then
    return nil
  end

  -- Extract title (first # header after frontmatter)
  local title = content:match("\n# (.-)%s*\n")
  if not title then
    return nil
  end

  -- Extract code block
  local lang, code = content:match("```(%w+)\n(.-)\n```")
  if not code then
    return nil
  end

  -- Extract language from frontmatter
  local lang_tag = frontmatter:match("lang:%s*(%w+)")

  return {
    title = title,
    code = code,
    lang = lang_tag or lang or "text",
    filepath = filepath,
  }
end

-- Load all snippets from directory
local function load_snippets()
  local snippets = {}
  local snippets_dir = vim.fn.expand("~/obsd/second-brain/snippets")

  if vim.fn.isdirectory(snippets_dir) == 0 then
    vim.notify("Snippets directory not found: " .. snippets_dir, vim.log.levels.WARN)
    return snippets
  end

  local files = vim.fn.glob(snippets_dir .. "/*.md", false, true)
  vim.notify("Found " .. #files .. " snippet files in " .. snippets_dir, vim.log.levels.INFO)

  for _, filepath in ipairs(files) do
    local snippet = parse_snippet_file(filepath)
    if snippet then
      table.insert(snippets, snippet)
    end
  end

  vim.notify("Loaded " .. #snippets .. " Obsidian snippets", vim.log.levels.INFO)
  return snippets
end

-- Blink.cmp source implementation
function M.new()
  return setmetatable({}, { __index = M })
end

function M:get_completions(context, callback)
  -- Load snippets if not cached
  if not M.snippets_cache then
    M.snippets_cache = load_snippets()
  end

  local items = {}
  
  for _, snippet in ipairs(M.snippets_cache) do
    table.insert(items, {
      label = snippet.title,
      kind = vim.lsp.protocol.CompletionItemKind.Snippet,
      insertText = snippet.code,
      documentation = {
        kind = "markdown",
        value = string.format("**%s** (%s)\n\n```%s\n%s\n```", snippet.title, snippet.lang, snippet.lang, snippet.code),
      },
      data = {
        filepath = snippet.filepath,
        lang = snippet.lang,
      },
    })
  end

  callback({
    is_incomplete_forward = false,
    is_incomplete_backward = false,
    items = items,
  })
end

function M:resolve(item, callback)
  callback(item)
end

-- Refresh cache command
vim.api.nvim_create_user_command("ObsidianSnippetsRefresh", function()
  M.snippets_cache = load_snippets()
  vim.notify("Refreshed " .. #M.snippets_cache .. " Obsidian snippets", vim.log.levels.INFO)
end, {})

return M
