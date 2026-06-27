--- LSP ---

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = { prefix = '●', spacing = 2 },
      float = { border = 'rounded', source = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
      },
    })

    vim.lsp.config('clangd', {
      cmd = { 'clangd', '--query-driver=/usr/bin/clang' },
    })
    vim.lsp.config('lua_ls', {
      settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
    })

    vim.lsp.enable({ 'clangd', 'lua_ls' })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('<leader>k', vim.lsp.buf.hover, 'Hover')
        map('<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
        map('<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format')
      end
    })
  end,
}
