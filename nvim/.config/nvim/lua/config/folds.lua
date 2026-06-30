--- Folds ---

local M = {}
local opt = vim.opt

local CLOSED = ''
local OPEN = ''

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldenable = true
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars:append({ fold = ' ' })
opt.foldtext = "v:lua.require'config.folds'.text()"
opt.statuscolumn =
  "%s%=%{%v:relnum == 0 ? v:lnum : v:relnum%} %{%v:lua.require'config.folds'.marker()%} "

local fold_cache = { key = nil, header = -1 }
local function cursor_fold_header()
  local cur = vim.fn.line('.')
  local key = cur .. ':' .. vim.fn.foldclosed(cur)
  if fold_cache.key == key then return fold_cache.header end
  local level, header = vim.fn.foldlevel(cur), -1
  if level > 0 then
    header = cur
    while header > 1 and vim.fn.foldlevel(header - 1) >= level do
      header = header - 1
    end
  end
  fold_cache.key, fold_cache.header = key, header
  return header
end

function M.marker()
  if vim.v.virtnum ~= 0 then return ' ' end
  local lnum = vim.v.lnum
  if vim.fn.foldclosed(lnum) == lnum then
    return '%#FoldArrowClosed#' .. CLOSED .. '%*'
  end
  if lnum == cursor_fold_header() then
    return '%#FoldArrowOpen#' .. OPEN .. '%*'
  end
  return ' '
end

local function ts_chunks(foldstart)
  local line = vim.fn.getline(foldstart)

  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if not ok or not parser then return { { line, 'Folded' } } end

  local query = vim.treesitter.query.get(parser:lang(), 'highlights')
  local tree = parser:parse({ foldstart - 1, foldstart })[1]
  if not query or not tree then return { { line, 'Folded' } } end

  local row, len = foldstart - 1, #line
  local hl, prio = {}, {}
  for id, node, metadata in query:iter_captures(tree:root(), 0, row, row + 1) do
    local sr, sc, er, ec = node:range()
    if sr <= row and er >= row then
      local s = (sr == row) and sc or 0
      local e = (er == row) and ec or len
      local p = tonumber(metadata.priority) or 100
      local group = '@' .. query.captures[id]
      for col = s, e - 1 do
        if prio[col] == nil or p >= prio[col] then hl[col], prio[col] = group, p end
      end
    end
  end

  local chunks, col = {}, 0
  while col < len do
    local group, start = hl[col] or 'Folded', col
    while col < len and (hl[col] or 'Folded') == group do col = col + 1 end
    chunks[#chunks + 1] = { line:sub(start + 1, col), group }
  end
  if #chunks == 0 then chunks = { { line, 'Folded' } } end
  return chunks
end

function M.text()
  local chunks = ts_chunks(vim.v.foldstart)
  local last = vim.fn.getline(vim.v.foldend):gsub('^%s*', '')
  local close = last:match('^[%)%]}]+')
  if not close and last:match('^end%f[%W]') then close = 'end' end

  chunks[#chunks + 1] = { ' ', 'Normal' }
  chunks[#chunks + 1] = { '...', 'Comment' }
  if close then
    local hl = close:match('^%a') and '@keyword' or '@punctuation.bracket'
    chunks[#chunks + 1] = { ' ', 'Normal' }
    chunks[#chunks + 1] = { close, hl }
  end
  return chunks
end

return M
