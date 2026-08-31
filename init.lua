vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

_G.THEME = ({
	DEFAULT = "onedark",
	LIGHT = "onelight",
	VIVID = "onedark_vivid",
	BLACK = "onedark_dark",
	VAPORWAVE = "vaporwave",
}).BLACK

require("config.plugins")
require("config.keymaps")
require("config.options")
require("config.autocmds")
