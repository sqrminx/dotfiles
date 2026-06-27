--- Oil ---


return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
  opts = {
    default_file_explorer = true,
    view_options = { show_hidden = true },
    float = { border = 'rounded' },
    confirmation = { border = 'rounded' },
    progress = { border = 'rounded' },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-r>'] = 'actions.refresh',
      ['q'] = 'actions.close',
    },
  },
}
