--- Completion ---

return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = {
      preset = 'enter',
      ['<tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<s-tab>'] = { 'select_next', 'snippet_backward', 'fallback' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true }
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },
  },
  config = function (_, opts)
    require('blink.cmp').setup(opts)
    vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
  end,
}
