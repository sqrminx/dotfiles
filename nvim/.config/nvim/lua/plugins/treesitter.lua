--- Treesitter ---

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  lazy = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
  opts = {
    ensure_installed = { 'bash', 'c', 'lua', 'vim', 'vimdoc', 'markdown' },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<cr>',
        node_incremental = '<cr>',
        node_decremental = '<bs>',
        scope_incremental = '<tab>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer', ['if'] = '@function.inner',
          ['ac'] = '@class.outer', ['ic'] = '@class.inner',
          ['ap'] = '@parameter.outer', ['ip'] = '@parameter.inner',
          ['ai'] = '@conditional.outer', ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer', ['il'] = '@loop.inner',
          ['acm'] = '@comment.outer',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
