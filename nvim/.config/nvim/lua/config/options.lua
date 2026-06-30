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
