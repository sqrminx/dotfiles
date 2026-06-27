--- Keymaps ---
local map = vim.keymap.set

-- Insert
map({ 'i' }, 'jk', '<esc>', { silent = true, desc = 'Exit insert mode' })

-- Motions — H/L: line start/end · K/J: buffer start/end
map({ 'n', 'o', 'v' }, 'H', '0', { silent = true, desc = 'Start of line' })
map({ 'n', 'o', 'v' }, 'J', 'G', { silent = true, desc = 'End of buffer' })
map({ 'n', 'o', 'v' }, 'K', 'gg', { silent = true, desc = 'Start of buffer' })
map({ 'n', 'o', 'v' }, 'L', '$', { silent = true, desc = 'End of line' })

-- Search
map({ 'n' }, '<esc>', '<cmd>nohlsearch<cr>', { silent = true, desc = 'Delete highlights' })

-- AZERTY bracket access
map({ 'n', 'o', 'x' }, 'ç', '[', { remap = true, desc = 'AZERTY: Act as [' })
map({ 'n', 'o', 'x' }, 'à', ']', { remap = true, desc = 'AZERTY: Act as ]' })

-- Terminal
map({ 't' }, '<esc><esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
