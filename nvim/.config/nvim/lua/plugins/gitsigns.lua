--- Gitsigns ---

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs_staged_enable = true,
    on_attach = function (buf)
      local gs = require('gitsigns')
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
      end

      map('n', ']h', function () gs.nav_hunk('next') end, 'Next hunk')
      map('n', '[h', function () gs.nav_hunk('prev') end, 'Prev hunk')

      map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
      map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>hb', function () gs.blame_line({ full = true }) end, 'Blame line')
      map('n', '<leader>hB', gs.toggle_current_line_blame, 'Toggle blame')
      map('n', '<leader>hd', gs.diffthis, 'Diff this')

      map('v', '<leader>hs', function () gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage selection')
    end
  }
}
