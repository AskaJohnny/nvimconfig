require("basic")
require("keybindings")
require("config/lazy")
-- require("colorscheme")
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

-- highlight! PmenuSel guibg=#8b668b guifg=#ffffff
vim.cmd([[
highlight! Pmenu guibg=#2e2a3a guifg=#f5c2e7
highlight! PmenuSel guibg=#8b668b guifg=#ffffff
highlight! FloatBorder guifg=#f5c2e7 guibg=#2e2a3a
highlight! NormalFloat guibg=#2e2a3a guifg=#f5c2e7
]])

vim.cmd([[
highlight! Search guibg=#ffcc00 guifg=#000000
highlight! IncSearch guibg=#ff6600 guifg=#ffffff ]])
-- 下面是这个 jb 需要设置的 后面3个 是 为了把编辑器背景当文件不满的时候 也能显示一样的 不然挺丑的
vim.cmd("colorscheme jb")
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "NONE" })
-- 确保 LineNr, SignColumn 和 Normal 背景一致
-- vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = "NONE" })
-- 这2个是 行背景
vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "NONE" })
-- 这个好像是切换到tree 和 主页面 有个颜色变化 导致
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "#212226", fg = "#E3E5E8" })

-- -- 设置补全菜单背景和前景颜色
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e1e", fg = "#ffffff" })
--
-- -- 设置选中项的背景和前景颜色，使其更加明显
-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5f87ff", fg = "#ffffff", bold = true })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#FF0000", bg = "NONE" })    -- 虚拟文本红色，背景透明
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF0000" }) -- 下划线红色

-- 设置 DiagnosticSignError 为绿色的竖线 |
vim.fn.sign_define("DiagnosticSignError", { text = "┃", texthl = "DiagnosticSignError", numhl = "" })
-- 设置 DiagnosticSignError 行号侧边的错误的 的颜色为绿色 这个为了和idea一样 , 也可以是红色fg = "#FF0000",
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#a8cc8c", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#FFA500", bg = "NONE" })

vim.diagnostic.config({
    virtual_text = {
        spacing = 2, -- 设置错误提示与代码的间距
        prefix = "●", -- 设置前缀符号，可以改为其他符号或移除
        severity = vim.diagnostic.severity.ERROR, -- 只显示错误的虚拟文本
    },
    signs = true, -- 在左侧边栏显示符号
    underline = true, -- 在有问题的代码下划线显示
    update_in_insert = false, -- 在插入模式下不更新诊断信息
    severity_sort = true, -- 根据严重程度对诊断进行排序
    float = {
        show_header = true, -- 在浮动窗口顶部显示诊断信息的标题
        source = "always", -- 在诊断信息中始终显示 LSP 源
        border = "rounded", -- 使用圆角边框
        focusable = false, -- 浮动窗口不可聚焦
        style = "minimal", -- 使用最小样式的浮动窗口
    },
})
-- 设置更新光标停留事件的时间间隔
vim.o.updatetime = 250

-- 自动显示浮动窗口
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- 补全菜单的背景颜色和前景颜色lsp
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e1e", fg = "#e5e5e5" })
-- 设置选中项的背景颜色和前景颜色
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#1e1e1e", fg = "#e5e5e5" })
-- 如果需要设置边框颜色
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#2c2c2c" })  -- 滑动条背景
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#3e4452" }) -- 滑动条高亮部分k
-- 诊断的浮动的窗口的  和 代码补全lsp的 一致
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e1e", fg = "#e5e5e5" })
-- 设置浮动窗口边框颜色为 #ffffff，背景与浮动窗口保持一致
--
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e1e", fg = "#e5e5e5" })

-- 以前有新的代码的地方有的阴影 背景
vim.api.nvim_set_hl(0, "JBDiffAddedLine", { fg = "NONE", bg = "NONE" })   -- 虚拟文本红色，背景透明
vim.api.nvim_set_hl(0, "JBDiffChangedLine", { fg = "NONE", bg = "NONE" }) -- 虚拟文本红色，背景透明

-- 侧边的git 状态 | 的颜色
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#5f9c64", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#3F6AB6", bg = "NONE" })

-- 这些都是通过:Inspect  找出来 并且按照idea 的配色去设置的
vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { fg = "#D59978", bold = true })
vim.api.nvim_set_hl(0, "@type.builtin.java", { fg = "#D59978", bold = true })
vim.api.nvim_set_hl(0, "@comment.documentation.java", { fg = "#5F826B", bold = true })
vim.api.nvim_set_hl(0, "@comment.java", { fg = "#7A7E85", bold = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.method.public.java", { fg = "#BCBEC4", bold = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.method.private.java", { fg = "#BCBEC4", bold = true })
-- vim.api.nvim_set_hl(0, "@spell.java", { fg = "#96BB46", bold = true })
vim.api.nvim_set_hl(0, "@string.java", { fg = "#75B47E", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.method.java", { fg = "#61B1F6", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.annotation.java", { fg = "#BBB76B", bold = true })
vim.api.nvim_set_hl(0, "@attribute.java", { fg = "#BBB76B", bold = true })

-- 文件夹和文件的名称的颜色 设置成和idea一样的白色
-- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#E3E5E8", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#C4C5CB", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#C4C5CB", bold = true })

-- 诊断的info 侧边 的下划线去掉
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = false })

-- 光标下的单词高亮 加一个背景  去掉下划线
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#373b39", underline = false})
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#373b39", underline = false })


