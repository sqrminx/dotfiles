--- Filetype ---

local ft = vim.filetype

ft.add({
  filename = {
    ['.COMMIT_MSG'] = 'gitcommit',
    ['.MERGE_MSG'] = 'gitcommit',
  },
})
