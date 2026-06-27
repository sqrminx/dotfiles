--- Finder ---

return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Help tags' },
    { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Grep word under cursor' },
  },
  opts = {
    fzf_colors = true,
    winopts = {
      heigh = 0.60,
      width = 0.50,
      preview = { hidden = true },
    },
    files = {
      cwd_prompt = false,
    },
  },
}
