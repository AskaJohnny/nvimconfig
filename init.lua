require("basic")
require("keybindings")
require("config/lazy")
require("colorscheme")

-- https://github.com/nvim-tree/nvim-tree.lua  根据这个nvim-tree的文档的要求 说要在init.lua 添加下面这3行
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data")
-- vim.notify("lazypath" .. lazypath)

-- vim.lsp.set_log_level("debug")

vim.cmd([[
  augroup ToggleTermFloat
    autocmd!
    " 在打开终端时设置状态栏显示
    autocmd TermOpen * if &buftype == 'terminal' | set laststatus=2 | endif
    " 在退出终端时重置状态栏显示
    autocmd TermClose * if &buftype == 'terminal' | set laststatus=2 | endif
  augroup END
]])

vim.api.nvim_create_user_command("PrintWinBufMap", function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        print("Window ID: " .. win .. ", Buffer ID: " .. buf)
    end
end, {})

-- -- 定义 winbar 的 Lua 函数
-- function MyWinbar()
--     if vim.bo.filetype == "toggleterm" then
--         print('jjjjj')
--         return "TERMINAL MODE"
--     else
--         return "%f %m"
--     end
-- end
--
-- -- 设置全局 winbar
-- vim.o.winbar = "%{%v:lua.MyWinbar()%}"
