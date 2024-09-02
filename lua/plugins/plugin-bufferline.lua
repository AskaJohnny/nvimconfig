return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    -- mode = "buffers", -- set to "tabs" to only show tabpages instead
                    mode = "buffers", -- set to "tabs" to only show tabpages instead
                    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
                    themable = true, -- allows highlight groups to be overridden
                    numbers = "none", -- use "ordinal" | "buffer_id" | "both" if needed
                    close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
                    left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
                    middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
                    indicator = {
                        icon = "▎", -- this should be omitted if indicator style is not 'icon'
                        style = "icon", -- 'icon' | 'underline' | 'none',
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    name_formatter = function(buf)
                        -- Custom logic for buffer names
                        return buf.name
                    end,
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true, -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = false,   -- "nvim_lsp" or "coc" can be used instead
                    diagnostics_update_in_insert = false, -- only applies to coc diagnostics_update_on_event = true, -- use nvim's diagnostic handler
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        return "(" .. count .. ")"
                    end,
                    custom_filter = function(buf_number, buf_numbers)
                        -- Custom filtering logic
                        return true
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "NvimTree",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_watches",
                            text = "dapui_watches",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_breakpoints",
                            text = "dapui_breakpoints",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_scopes",
                            text = "dapui_scopes",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    get_element_icon = function(element)
                        -- Custom logic to get the icon for the element
                        local icon, hl =
                            require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
                        return icon, hl
                    end,
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                    duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
                    separator_style = "slant", -- "slope" | "thick" | "thin" | { 'any', 'any' },
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                    sort_by = "insert_after_current", -- other options: 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
                },
            })
            -- bufferline 快捷键映射
            local opts = { noremap = true, silent = true }

            -- 切换到上一个/下一个 buffer
            vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", opts)

            -- 按住 Alt + 数字键直接跳转到对应位置的 buffer
            vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A-0>", "<Cmd>BufferLineGoToBuffer -1<CR>", opts) -- -1 跳转到最后一个 buffer

            -- 移动 buffer 的位置
            vim.api.nvim_set_keymap("n", "<A-<>", "<Cmd>BufferLineMovePrev<CR>", opts)
            vim.api.nvim_set_keymap("n", "<A->>", "<Cmd>BufferLineMoveNext<CR>", opts)

            -- Pin/unpin buffer (暂时未被 bufferline.nvim 支持)
            -- vim.api.nvim_set_keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)  -- 目前没有 pin 功能

            vim.api.nvim_set_keymap("n", "<A-o>", "<Cmd>BufferLineCloseOthers<CR>", opts)

            -- 下面是gpt帮我生成的 关于关闭当前 buffer ,因为bufferline 没有提供关闭当前的 barbar提供了 ,但是bufferline提供了 关闭other
            local function CloseCurrentAndFocusLeft()
                -- 获取当前缓冲区和左侧缓冲区的编号
                local current_buf = vim.api.nvim_get_current_buf()
                local prev_buf = vim.fn.bufnr("#")
                -- 获取所有列出的缓冲区
                local buffers = vim.fn.getbufinfo({ buflisted = 1 })

                -- 如果只有一个缓冲区，则不执行关闭操作
                if #buffers <= 1 then
                    print("Only one buffer open, cannot close the current buffer.")
                    return
                end

                -- 如果没有其他缓冲区，直接返回
                if prev_buf == -1 then
                    print("No left buffer to focus.")
                    return
                end

                -- 切换到左侧缓冲区
                vim.cmd("b " .. prev_buf)

                -- 删除当前缓冲区
                vim.cmd("bdelete " .. current_buf)
            end

            -- 将函数绑定到快捷键
            vim.api.nvim_set_keymap(
                "n",
                "<leader>q",
                "",
                { noremap = true, silent = true, callback = CloseCurrentAndFocusLeft }
            )
            -- vim.api.nvim_set_keymap(
            --     "n",
            --     "<leader>q",
            --     "<cmd>lua close_current_and_focus_left()<CR>",
            --     { noremap = true, silent = true }
            -- )
        end,
    },
}
