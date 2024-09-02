return {
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
            local hl = require("actions-preview.highlight")
            require("actions-preview").setup({
                -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
                diff = {
                    ctxlen = 3,
                },

                -- priority list of external command to highlight diff
                -- disabled by defalt, must be set by yourself
                highlight_command = {
                    -- require("actions-preview.highlight").delta(),
                    -- require("actions-preview.highlight").diff_so_fancy(),
                    -- require("actions-preview.highlight").diff_highlight(),
                    hl.delta("delta --no-gitconfig --side-by-side"),
                },

                -- priority list of preferred backend
                backend = { "telescope", "nui" },

                -- options related to telescope.nvim
                telescope = vim.tbl_extend(
                    "force",
                    -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
                    require("telescope.themes").get_dropdown(),
                    -- a table for customizing content
                    {
                        layout_config = {
                            width = 0.7, -- 设置宽度为屏幕宽度的50%
                            -- 你也可以设置高度
                            height = 0.3, -- 设置高度为屏幕高度的40%
                            preview_cutoff = 10, -- 仅在窗口宽度大于此值时显示预览器
                        },
                        -- a function to make a table containing the values to be displayed.
                        -- fun(action: Action): { title: string, client_name: string|nil }
                        make_value = nil,

                        -- a function to make a function to be used in `display` of a entry.
                        -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
                        -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
                        make_make_display = nil,
                        previewer = true, -- 关闭预览窗口，通常对 code actions 不需要预览
                        prompt_title = false, -- 是否显示提示标题，false 表示隐藏
                    }
                ),

                -- options for nui.nvim components
                nui = {
                    -- component direction. "col" or "row"
                    dir = "col",
                    -- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
                    keymap = nil,
                    -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
                    layout = {
                        position = "50%",
                        size = {
                            width = "60%",
                            height = "90%",
                        },
                        min_width = 40,
                        min_height = 10,
                        relative = "editor",
                    },
                    -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
                    preview = {
                        size = "60%",
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                    },
                    -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
                    select = {
                        size = "40%",
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                    },
                },
            })
        end,
    },
}
