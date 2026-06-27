--- Smart splits ---

return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  config = function()
    local ss = require('smart-splits')
    ss.setup({ at_edge = 'stop' })

    local map = vim.keymap.set
    map('n', '<C-h>', ss.move_cursor_left,  { desc = 'Move to left split/pane' })
    map('n', '<C-j>', ss.move_cursor_down,  { desc = 'Move to below split/pane' })
    map('n', '<C-k>', ss.move_cursor_up,    { desc = 'Move to above split/pane' })
    map('n', '<C-l>', ss.move_cursor_right, { desc = 'Move to right split/pane' })
    map('t', '<C-h>', ss.move_cursor_left,  { desc = 'Move to left split/pane' })
    map('t', '<C-j>', ss.move_cursor_down,  { desc = 'Move to below split/pane' })
    map('t', '<C-k>', ss.move_cursor_up,    { desc = 'Move to above split/pane' })
    map('t', '<C-l>', ss.move_cursor_right, { desc = 'Move to right split/pane' })

    local resize = { h = ss.resize_left, j = ss.resize_down, k = ss.resize_up, l = ss.resize_right }
    local function resize_mode()
      while true do
        vim.api.nvim_echo({ { 'Resize - hjkl / esc', 'ModeMsg' } }, false, {})
        vim.cmd('redraw')
        local ok, ch = pcall(vim.fn.getcharstr)
        local action = ok and resize[ch]
        if not action then break end
        action()
      end
      vim.api.nvim_echo({ { '' } }, false, {})
    end
    map('n', '<leader>R', resize_mode, { desc = 'Resize - hjkl / esc' })
  end,
}
