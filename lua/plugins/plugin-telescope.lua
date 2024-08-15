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
        })

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fi", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
    end,
}
