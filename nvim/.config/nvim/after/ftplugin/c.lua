--- After ftplugin C ---

vim.bo.errorformat = table.concat({
  '%f:%l:%c: %trror: %m',
  '%f:%l:%c: %tarning: %m',
  '%-G%.%#',
}, ',')
