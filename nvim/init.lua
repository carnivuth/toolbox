-- https://neovim.io/doc/user/lua-guide.html for configuration guide

-- mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lsp configurations
require("lsp.lua")
require("lsp.python")
require("lsp.go")
require("lsp.ansible")
require("lsp.bash")
require("lsp.terraform")
