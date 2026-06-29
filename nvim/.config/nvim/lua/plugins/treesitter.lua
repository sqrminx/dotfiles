--- Treesitter ---

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  config = function ()
    require('nvim-treesitter').install(
      {
        'bash', 'c', 'lua',
        'vim', 'vimdoc',
        'markdown', 'markdown_inline'
      }
    )

    vim.api.nvim_create_autocmd('FileType', {
      callback = function ()
        if not pcall(vim.treesitter.start) then return end
      end,
    })
  end
}
