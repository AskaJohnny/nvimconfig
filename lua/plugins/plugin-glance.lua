return {
    {
        "DNLHC/glance.nvim",
        config = function()
            -- Lua configuration
            local glance = require("glance")
            local actions = glance.actions

            glance.setup({
                height = 18, -- Height of the window
                zindex = 45,

                -- By default glance will open preview "embedded" within your active window
                -- when `detached` is enabled, glance will render above all existing windows
                -- and won't be restiricted by the width of your active window
                detached = true,

                -- Or use a function to enable `detached` only when the active window is too small
                -- (default behavior)
                -- detached = function(winid)
                --     return vim.api.nvim_win_get_width(winid) < 100
                -- end,

                preview_win_opts = { -- Configure preview window options
                    cursorline = true,
                    number = true,
                    wrap = true,
                },
                border = {
                    enable = false, -- Show window borders. Only horizontal borders allowed
                    top_char = "―",
                    bottom_char = "―",
                },
                list = {
                    position = "left", -- Position of the list window 'left'|'right'
                    width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
                },
                theme = { -- This feature might not work properly in nvim-0.7.2
                    enable = true, -- Will generate colors for the plugin based on your current colorscheme
                    mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
                },
                mappings = {
                    list = {
                        ["j"] = actions.next, -- Bring the cursor to the next item in the list
                        ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
                        ["<Down>"] = actions.next,
                        ["<Up>"] = actions.previous,
                        ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
                        ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                        ["<C-u>"] = actions.preview_scroll_win(5),
                        ["<C-d>"] = actions.preview_scroll_win(-5),
                        ["v"] = actions.jump_vsplit,
                        ["s"] = actions.jump_split,
                        ["t"] = actions.jump_tab,
                        ["<CR>"] = actions.jump,
                        -- 这个和lspdaga 一样的快捷键
                        ["o"] = actions.jump,
                        ["l"] = actions.open_fold,
                        ["h"] = actions.close_fold,
                        ["<C-l>"] = actions.enter_win("preview"), -- Focus preview window
                        ["q"] = actions.close,
                        ["Q"] = actions.close,
                        ["<Esc>"] = actions.close,
                        -- 默认是 <leader>l 我改成和统一的窗口跳转一样的快捷键
                        ["<C-q>"] = actions.quickfix,
                        -- ['<Esc>'] = false -- disable a mapping
                    },
                    preview = {
                        -- 这个默认是Q 不懂为啥, 我这里改成小q
                        ["q"] = actions.close,
                        ["<Tab>"] = actions.next_location,
                        ["<S-Tab>"] = actions.previous_location,
                        -- 默认是 <leader>l 我改成和统一的窗口跳转一样的快捷键
                        ["<C-h>"] = actions.enter_win("list"), -- Focus list window
                    },
                },
                hooks = {
                    -- open 之前的hook 操作 ,主要是过滤掉自己的这个, 和 如果是只有一个结果ref或imp 则直接跳过去
                    before_open = function(results, open, jump, method)
                        local uri = vim.uri_from_bufnr(0)
                        local filtered_results = {}
                        if method == 'definitions' then
                            -- 如果是定义 , 比如 在一个变量gd 就不需要过滤 
                            filtered_results = results
                        else
                            filtered_results = results
                            -- for _, result in ipairs(results) do
                            --     local target_uri = result.uri or result.targetUri
                            --     -- 这里是为了 不把这个自己展示上去 比如一个方法 ref的时候会有它自己
                            --     if target_uri ~= uri then
                            --         table.insert(filtered_results, result)
                            --     end
                            -- end
                        end
                        -- 如果没有过滤后的结果，直接返回, 不然会抛错 gd的时候如果本身就是定义那么这个{} 是一个空
                        if #filtered_results == 0 then
                            return
                        end
                        if #filtered_results == 1 then
                            local target_uri = filtered_results[1].uri or filtered_results[1].targetUri
                            -- 这里是为了如果只有一个实现 一个引用 直接跳过去和idea一样 lspsaga 不行 一个也显示弹框
                            jump(filtered_results[1])
                        else
                            open(filtered_results)
                        end
                    end,
                },
                folds = {
                    fold_closed = "",
                    fold_open = "",
                    -- 这里是我改成了false 让它默认直接展开
                    folded = false, -- Automatically fold list on startup
                },
                indent_lines = {
                    enable = true,
                    icon = "│",
                },
                winbar = {
                    enable = true, -- Available strating from nvim-0.8+
                },
                use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list window
            })
        end,
    },
}
