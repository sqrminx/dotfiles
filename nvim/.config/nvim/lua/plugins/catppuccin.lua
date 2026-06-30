--- Catppuccin ---

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    term_colors = true,
    custom_highlights = function (colors)
      return {
        MsgArea = { fg = colors.overlay2 },
        Whitespace = { fg = colors.red },
        FoldArrowClosed = { fg = colors.pink },
        FoldArrowOpen = { fg = colors.overlay2 },
        NormalFloat = { bg = 'NONE' },
        FloatBorder = { fg = colors.surface1, bg = 'NONE' },
        gitcommitOverflow = { fg = colors.red },
        gitcommitSummary = { fg = colors.text, bold = true },
        BlinkCmpMenu = { bg = colors.surface0 },
        BlinkCmpDoc = { bg = colors.surface0 },
        BlinkCmpSignatureHelp = { bg = colors.surface0 },
      }
    end,
    integrations = {
      treesitter = true,
      gitsigns = true,
      native_lsp = { enabled = true },
    },
  },
  config = function (_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
