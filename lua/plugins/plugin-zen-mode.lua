return {
    {
        "folke/zen-mode.nvim",
        opts = {},
        config = function()
            --vim.keymap.set("n", "<leader>fu", ":ZenMode<CR>", { noremap = true, silent = true })
            require("zen-mode").setup({
                window = {
                    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                    -- height and width can be:
                    -- * an absolute number of cells when > 1
                    -- * a percentage of the width / height of the editor when <= 1
                    -- * a function that returns the width or the height
                    width = 125, -- width of the Zen window
                    height = 1, -- height of the Zen window
                    -- by default, no options are changed for the Zen window
                    -- uncomment any of the options below, or add other vim.wo options you want to apply
                    options = {
                        -- signcolumn = "no", -- disable signcolumn
                        -- number = false, -- disable number column
                        -- relativenumber = false, -- disable relative numbers
                        -- cursorline = false, -- disable cursorline
                        -- cursorcolumn = false, -- disable cursor column
                        -- foldcolumn = "0", -- disable fold column
                        -- list = false, -- disable whitespace characters
                    },
                },
                plugins = {
                    -- disable some global vim options (vim.o...)
                    -- comment the lines to not apply the options
                    options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                        -- you may turn on/off statusline in zen mode by setting 'laststatus'
                        -- statusline will be shown only if 'laststatus' == 3
                        laststatus = 0, -- turn off the statusline in zen mode
                    },
                    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
                    gitsigns = { enabled = false }, -- disables git signs
                    tmux = { enabled = false }, -- disables the tmux statusline
                    todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
                    -- this will change the font size on kitty when in zen mode
                    -- to make this work, you need to set the following kitty options:
                    -- - allow_remote_control socket-only
                    -- - listen_on unix:/tmp/kitty
                    kitty = {
                        enabled = false,
                        font = "+4", -- font size increment
                    },
                    -- this will change the font size on alacritty when in zen mode
                    -- requires  Alacritty Version 0.10.0 or higher
                    -- uses `alacritty msg` subcommand to change font size
                    alacritty = {
                        enabled = false,
                        font = "14", -- font size
                    },
                    -- this will change the font size on wezterm when in zen mode
                    -- See alse also the Plugins/Wezterm section in this projects README
                    wezterm = {
                        enabled = false,
                        -- can be either an absolute font size or the number of incremental steps
                        font = "+4", -- (10% increase per step)
                    },
                    -- this will change the scale factor in Neovide when in zen mode
                    -- See alse also the Plugins/Wezterm section in this projects README
                    neovide = {
                        enabled = false,
                        -- Will multiply the current scale factor by this number
                        scale = 1.2,
                        -- disable the Neovide animations while in Zen mode
                        disable_animations = {
                            neovide_animation_length = 0,
                            neovide_cursor_animate_command_line = false,
                            neovide_scroll_animation_length = 0,
                            neovide_position_animation_length = 0,
                            neovide_cursor_animation_length = 0,
                            neovide_cursor_vfx_mode = "",
                        },
                    },
                },
                -- callback where you can add custom code when the Zen window opens
                on_open = function(win) end,
                -- callback where you can add custom code when the Zen window closes
                on_close = function() end,
            })
            vim.keymap.set("n", "<leader>fu", ":ZenMode<CR>", { noremap = true, silent = true })

            -- 创建一个表来保存每个窗口的高度和宽度
            local window_sizes = {}

            -- 定义隐藏窗口的函数
            local function HideWindow()
                -- 获取当前窗口的ID
                local win_id = vim.api.nvim_get_current_win()
                -- 保存当前窗口的高度和宽度
                window_sizes[win_id] = {
                    height = vim.api.nvim_win_get_height(win_id),
                    width = vim.api.nvim_win_get_width(win_id),
                }
                -- 将窗口的高度和宽度设置为1（相当于最小化）
                vim.cmd("resize 1")
                --vim.cmd("vertical resize 1")
            end

            -- 定义恢复窗口的函数
            local function RestoreWindow()
                -- 获取当前窗口的ID
                local win_id = vim.api.nvim_get_current_win()
                -- 检查是否已经保存了该窗口的高度和宽度
                if window_sizes[win_id] then
                    -- 恢复窗口的高度和宽度
                    vim.cmd("resize " .. window_sizes[win_id].height)
                    vim.cmd("vertical resize " .. window_sizes[win_id].width)
                else
                    print("No size saved for this window!")
                end
            end
            -- 绑定快捷键，直接调用局部函数
            vim.api.nvim_set_keymap("n", "<leader>fm", "", { noremap = true, silent = true, callback = HideWindow })
            vim.api.nvim_set_keymap("n", "<leader>fr", "", { noremap = true, silent = true, callback = RestoreWindow })
            -- 绑定快捷键
            -- vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua HideWindow()<CR>", { noremap = true, silent = true })
            -- vim.api.nvim_set_keymap(
            --     "n",
            --     "<leader>fr",
            --     "<cmd>lua RestoreWindow()<CR>",
            --     { noremap = true, silent = true }
            -- )
        end,
    },
}
