-- https://neovim.io/doc/user/lua-guide.html for configuration guide

-- mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.filetypes")
require("config.keymaps")
require("config.autocmds")

-- lsp configurations
require("lsp")

-- OPTIONS
vim.o.relativenumber=true
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.expandtab=true
vim.o.incsearch=true
vim.o.hlsearch=true
vim.o.history=1000
vim.o.wildmenu=true
vim.o.wildmode="list:longest"
vim.opt.wildignore={'*.docx','*.jpg','*.png','*.gif','*.pdf','*.pyc','*.exe','*.flv','*.img','*.xlsx'}
vim.o.showcmd=true
vim.cmd.colorscheme "catppuccin"
