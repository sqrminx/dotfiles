--- Autocmds ---

local group = vim.api.nvim_create_augroup('config', { clear = true })
local function autocmd(event, opts)
  opts.group = group
  vim.api.nvim_create_autocmd(event, opts)
end

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- No line numbers in the terminal
autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Don't auto-continue comments on o / <cr>
autocmd('FileType', {
  callback = function()
    vim.opt_local.formatoptions:remove({ 'o', 'r' })
  end
})

-- Close scratch/readonly buffers with q
autocmd('FileType', {
  pattern = { 'help', 'qf', 'man', 'lspinfo', 'checkhealth', 'startuptime' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = ev.buf, silent = true })
  end,
})

-- Re-equalize splits on resize
autocmd('VimResized', {
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- Restore cursor to last position
autocmd('BufReadPost', {
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lines = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Color column
autocmd('FileType', {
  pattern = { 'c', 'lua', 'sh', 'bash', 'zsh' },
  callback = function () vim.opt_local.colorcolumn = '100' end,
})

autocmd('FileType', {
  pattern = { 'markdown', 'text' },
  callback = function () vim.opt_local.colorcolumn = '80' end,
})

autocmd('FileType', {
  pattern = { 'gitcommit' },
  callback = function () vim.opt_local.colorcolumn = '72' end,
})
