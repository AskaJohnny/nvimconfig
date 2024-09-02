return {
    {
        -- 添加不同语言
        "git@github.com:nvim-treesitter/nvim-treesitter.git",
        dependencies = {
            "p00f/nvim-ts-rainbow",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- 添加不同语言
                ensure_installed = { "lua", "python", "html", "vue" }, -- one of "all" or a list of languages
                sync_install = false,
                auto_install = true,
                -- List of parsers to ignore installing (or "all")
                ignore_install = {},
                highlight = {
                    enable = true,
                    disable = {},
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    --		    disable = function(lang, buf)
                    --			local max_filesize = 100 * 1024 -- 100 KB
                    --			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    --			if ok and stats and stats.size > max_filesize then
                    --			    return true
                    --			end
                    --		    end,
                },
                indent = { enable = true },

                -- 启用增量选择 设置为空格键
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>", -- set to `false` to disable one of the mappings
                        node_incremental = "<CR>",
                        -- scope_incremental = "<BS>",
                        -- node_decremental = "<BS>",
                    },
                },
                --                rainbow = {
                --                    enable = true,
                --                    extended_mode = true, -- 也为非括号字符设置颜色
                --                    max_file_lines = nil, -- 不限制文件行数
                --                },
                --
                --
                -- 启用 Text Objects 扩展
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- 在移动到下一个选择时，类似于 IDE 的智能选择
                        keymaps = {
                            -- 用于选择文本对象的键映射
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aC"] = "@conditional.outer",
                            ["iC"] = "@conditional.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ap"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- 设置在跳转时自动加入跳转列表
                        goto_next_start = {

                            ["<leader>od"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            -- ["]m"] = "@function.outer",
                            -- ["]c"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["<leader>ou"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            -- ["[m"] = "@function.outer",
                            -- ["[c"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                    -- swap = {
                    -- 	enable = true,
                    -- 	swap_next = {
                    -- 		["<leader>a"] = "@parameter.inner",
                    -- 	},
                    -- 	swap_previous = {
                    -- 		["<leader>A"] = "@parameter.inner",
                    -- 	},
                    -- },
                },
            })
        end,
    },
}
