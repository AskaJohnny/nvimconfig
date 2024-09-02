return {
    "git@github.com:nvim-telescope/telescope.nvim.git",
    tag = "0.1.5",
    -- or                              , branch = '0.1.x',
    dependencies = { "git@github.com:nvim-lua/plenary.nvim.git" },

    config = function()
        local builtin = require("telescope.builtin")
        require("telescope").setup({
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom", -- 提示符位于窗口顶部
                        preview_width = 0.5, -- 预览窗口占用总宽度的 55%
                        results_width = 0.7, -- 结果窗口占用总宽度的 80%
                    },
                    width = 0.9,  -- Telescope 窗口占用总宽度的 87%
                    height = 0.80, -- Telescope 窗口占用总高度的 80%
                    preview_cutoff = 120, -- 当窗口宽度小于 120 时，不显示预览窗口
                },
                path_display = {
                    shorten = { len = 1, exclude = { 1, -1, -2 } },
                },
                -- -- path_display = {
                --     "tail"
                -- },
                -- 其他默认配置...
            },
            -- extensions = {
            --     ["ui-select"] = {
            --         require("telescope.themes").get_dropdown({
            --             -- 设置弹框的宽度和高度
            --             width = 50, -- 50% of the screen width
            --             height = 50, -- 40% of the screen height
            --             previewer = true, -- 关闭预览窗口，通常对 code actions 不需要预览
            --             prompt_title = false, -- 是否显示提示标题，false 表示隐藏
            --         }),
            --
            --         -- pseudo code / specification for writing custom displays, like the one
            --         -- for "codeactions"
            --         -- specific_opts = {
            --         --   [kind] = {
            --         --     make_indexed = function(items) -> indexed_items, width,
            --         --     make_displayer = function(widths) -> displayer
            --         --     make_display = function(displayer) -> function(e)
            --         --     make_ordinal = function(e) -> string
            --         --   },
            --         --   -- for example to disable the custom builtin "codeactions" display
            --         --      do the following
            --         --   codeactions = false,
            --         -- }
            --     },
            -- },
        })
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fi", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})

    end,
}
