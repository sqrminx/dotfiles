--- Lualine ---

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local C = require('catppuccin.palettes').get_palette('macchiato')
    local flat = {
      normal = {
        a = { fg = C.mauve,   bg = 'NONE', gui = 'bold' },
        b = { fg = C.overlay0, bg = 'NONE' },
        c = { fg = C.overlay0, bg = 'NONE' },
      },
      insert   = { a = { fg = C.green,  bg = 'NONE', gui = 'bold' } },
      visual   = { a = { fg = C.yellow, bg = 'NONE', gui = 'bold' } },
      replace  = { a = { fg = C.red,    bg = 'NONE', gui = 'bold' } },
      command  = { a = { fg = C.blue,   bg = 'NONE', gui = 'bold' } },
      inactive = {
        a = { fg = C.overlay0, bg = 'NONE' },
        b = { fg = C.overlay0, bg = 'NONE' },
        c = { fg = C.overlay0, bg = 'NONE' },
      },
    }

    require('lualine').setup({
      options = {
        theme = flat,
        component_separators = '',
        section_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', right_padding = 2 } },
        lualine_b = {
          { 'filename', path = 1, symbols = { modified = '', readonly = '' } },
          'diff',
        },
        lualine_c = {},
        lualine_x = { 'diagnostics' },
        lualine_y = { { 'filetype', colored = false }, 'progress' },
        lualine_z = { { 'location', left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      extensions = { 'quickfix' },
    })
  end,
}
