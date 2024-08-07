require('basic')
require('keybindings')
require('config/lazy')
require('colorscheme')


-- https://github.com/nvim-tree/nvim-tree.lua  根据这个nvim-tree的文档的要求 说要在init.lua 添加下面这3行
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data")
vim.notify("lazypath" .. lazypath)

