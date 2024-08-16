vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前 map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h", opt) map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

map("i", "jk", "<ESC>", opt)
-- 这是在jk 下表示esc
map("t", "jk", "<C-\\><C-n>", opt)
--operator-pending mode 模式下
map("o", "jk", "<ESC>", opt)
map("n", "<leader>w", "<C-w>", opt)

---视觉模式V-----
map("v", "jk", "<ESC>", opt)
-- 单行或多行移动
map("v", "J", ":m '>+1<CR>gv=gv", opt)
map("v", "K", ":m '<-2<CR>gv=gv", opt)

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>", opt)

-- Terminal相关
-- map("n", "<leader>t", ":sp | terminal<CR>", opt)
-- 使用 toggleterm 插件了 不用这个 lspsaga
-- map("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opt)
-- map("t", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opt)

-- lsp gi gr gd
-- lspsaga 感觉不太好用
-- map('n', 'gi', '<cmd>Lspsaga finder imp<CR>', opt)
-- map('n', 'gr', '<cmd>Lspsaga finder ref<CR>', opt)
map("n", "<leader>co", "<cmd>Lspsaga outline<CR>", opt)
map("n", "<leader>ck", "<cmd>Lspsaga show_buf_diagnostics<CR>", opt)
map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)

-- glance
map("n", "gi", "<cmd>Glance implementations<CR>", opt)
map("n", "gr", "<cmd>Glance references<CR>", opt)
map("n", "gd", "<cmd>Glance definitions<CR>", opt)

map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opt)

