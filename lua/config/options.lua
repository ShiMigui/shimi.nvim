local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.undofile = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.clipboard = "unnamedplus"

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.hidden = true

opt.backspace = { "indent", "eol", "start" }

opt.wildmode = "longest:full,full"
