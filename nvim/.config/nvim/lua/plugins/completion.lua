--- Completion ---

return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<c-j>'] = { 'select_next', 'fallback' },
      ['<c-k>'] = { 'select_prev', 'fallback' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = false }
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path' },
    },
  },
  config = function (_, opts)
    require('blink.cmp').setup(opts)
    vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
  end,
}
