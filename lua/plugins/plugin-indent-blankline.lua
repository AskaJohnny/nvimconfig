return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function()
            local highlight = {
                "RainbowGreen",
            }

            local hooks = require("ibl.hooks")
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                -- 取色器取的 idea的颜色
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#313438" })
            end)

            require("ibl").setup({ indent = { highlight = highlight } })
            require("ibl").overwrite({
                exclude = { filetypes = {} },
                -- gpt给我的 最细的
                -- indent = { char = "│" },
                indent = { char = "┆" },
                -- 去掉 这个一个方法的最开始的标记 (模式是true 有一个方法最开始的下划线)
                scope = { show_start = false },
            })
        end,
    },
}
