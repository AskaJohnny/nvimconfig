return {
    {

        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            require("luasnip").setup({
                require("luasnip.loaders.from_vscode").lazy_load(),
                -- print('lazy_load000000000000000');
                --                以下是一些常见的 TextMate 变量，部分前面已提到：
                --
                -- TM_FILENAME: 当前文件的名称（包括扩展名）。
                -- TM_FILENAME_BASE: 当前文件的名称（不包括扩展名）。
                -- TM_DIRECTORY: 当前文件的路径（不包括文件名）。
                -- TM_FULLNAME: 用户的全名（如果配置了）。
                -- TM_USERNAME: 当前系统用户名。
                -- TM_SELECTED_TEXT: 当前选中的文本。
                -- TM_CURRENT_LINE: 当前行的内容。
                -- TM_CURRENT_WORD: 光标下的单词。
                -- TM_LINE_INDEX: 当前行的索引，从 0 开始。
                -- TM_LINE_NUMBER: 当前行的行号，从 1 开始。
                -- TM_YEAR, TM_MONTH, TM_DAY: 当前的日期部分（年、月、日）。
                -- TM_TIME: 当前时间。
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { "/Users/johnny/.config/nvim/ftplugin/snippets/" },
                }),
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { "/Users/johnny/.config/nvim/lua/snippetes/" },
                }),
                -- require("luasnip.loaders.from_vscode").lazy_load("/Users/johnny/.local/share/nvim/lazy/friendly-snippets"),
                -- require("luasnip.test"),
            })
        end,
    },
}
