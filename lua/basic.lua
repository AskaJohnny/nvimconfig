-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- 使用相对行号
vim.wo.number = true
-- vim.wo.relativenumber = true
-- 高亮所在的行
vim.wo.cursorline = true

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
-- vim.wo.colorcolumn = "120"

vim.o.showtabline = 2

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--系统剪切板
vim.opt.clipboard:append('unnamedplus')
-- 搜索
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- 外观
vim.opt.termguicolors = true


vim.o.hidden = true

--timeout

