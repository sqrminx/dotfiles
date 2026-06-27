--- Options ---
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.colorcolumn = ""
opt.scrolloff = 4
opt.wrap = false
opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣", }

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Folding (treesitter)
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldenable = false
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files & behaviour
opt.undofile = true
opt.updatetime = 250
