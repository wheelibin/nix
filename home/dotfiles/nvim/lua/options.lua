vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

local opt = vim.opt

-- disable word wrap
opt.wrap = false

-- Enable break indent
opt.breakindent = true

-- persistent undo history
opt.undofile = true

-- line numbers
opt.number = true
-- opt.relativenumber = true

-- sync clipboard between nvim and OS
opt.clipboard = 'unnamedplus'

-- search flags
opt.ignorecase = true
opt.smartcase = true

-- whitespace
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Decrease update time
opt.updatetime = 200
opt.timeoutlen = 500

-- show sign column
opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- needed for colorizer
opt.termguicolors = true

-- enable the mouse in (a)ll modes
opt.mouse = 'a'

-- scroll offset
opt.scrolloff = 8

-- full line at cursor position
opt.cursorline = true

opt.swapfile = false

-- cursor not allowed in whitespace
opt.virtualedit = 'none'

-- hide the tildes showing end of buffer
opt.fcs = "eob: "

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.foldlevel = 99
opt.foldmethod = "indent"

opt.conceallevel = 2

opt.winborder = 'rounded'

-- sane split options
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
