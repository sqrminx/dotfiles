--- Catppuccin ---

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    term_colors = true,
    custom_highlights = function(colors)
      return {
        MsgArea = { fg = colors.overlay2 },
        Whitespace = { fg = colors.red },
        FzfLuaNormal = { fg = colors.text, bg = 'NONE' },
        FzfLuaBorder = { fg = colors.surface1, bg = 'NONE' },
      }
    end,
    integrations = {
      treesitter = true,
      gitsigns = true,
      native_lsp = { enabled = true },
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
