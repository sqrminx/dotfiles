--- Treesitter ---

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  config = function ()
    local map = vim.keymap.set

    require('nvim-treesitter').install(
      {
        'bash', 'c', 'lua',
        'vim', 'vimdoc',
        'markdown', 'markdown_inline'
      }
    )

    require('nvim-treesitter-textobjects').setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    local sel = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local rep = require('nvim-treesitter-textobjects.repeatable_move')

    local select_maps = {
      af = '@function.outer', ['if'] = '@function.inner',
      ac = '@class.outer', ic = '@class.inner',
      ap = '@parameter.outer', ip = '@parameter.inner',
      ai = '@conditional.outer', ii = '@conditional.inner',
      al = '@loop.outer', il = '@loop.inner',
      acm = '@comment.outer',
    }
    for lhs, obj in pairs(select_maps) do
      map({ 'x', 'o' }, lhs, function () sel.select_textobject(obj, 'textobjects') end, { desc = 'Select ' .. obj })
    end

    local move_maps = {
      [']f'] = { move.goto_next_start, '@function.outer' },
      ['[f'] = { move.goto_previous_start, '@function.outer' },
      [']c'] = { move.goto_next_start, '@class.outer' },
      ['[c'] = { move.goto_previous_start, '@class.outer' },
    }
    for lhs, m in pairs(move_maps) do
      map({ 'n', 'x', 'o' }, lhs, function () m[1](m[2], 'textobjects') end, { desc = 'Move ' .. lhs })
    end

    map({ 'n', 'x', 'o' }, ';', rep.repeat_last_move)
    map({ 'n', 'x', 'o' }, ',', rep.repeat_last_move_opposite)
    map({ 'n', 'x', 'o' }, 'f', rep.builtin_f_expr, { expr = true })
    map({ 'n', 'x', 'o' }, 'F', rep.builtin_F_expr, { expr = true })
    map({ 'n', 'x', 'o' }, 't', rep.builtin_t_expr, { expr = true })
    map({ 'n', 'x', 'o' }, 'T', rep.builtin_T_expr, { expr = true })

    local swap = require('nvim-treesitter-textobjects.swap')
    map({ 'n' }, '<leader>sl', function () swap.swap_next('@parameter.inner') end, { desc = 'Swap param right' })
    map({ 'n' }, '<leader>sh', function () swap.swap_previous('@parameter.inner') end, { desc = 'Swap param left' })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function ()
        if not pcall(vim.treesitter.start) then return end
      end,
    })
  end
}
