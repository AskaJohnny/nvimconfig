return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local tree_api = require("nvim-tree")
        local tree_view = require("nvim-tree.view")

        vim.api.nvim_create_augroup("NvimTreeResize", {
            clear = true,
        })

        vim.api.nvim_create_autocmd({ "VimResized" }, {
            group = "NvimTreeResize",
            callback = function()
                if tree_view.is_visible() then
                    tree_view.close()
                    tree_api.open()
                end
            end,
        })

        local api = require("nvim-tree.api")
        local function tree_open_status_toggle()
            -- api.tree.toggle({ focus = true })
            api.tree.toggle()
        end
        vim.keymap.set("n", "<C-t>", tree_open_status_toggle)

        vim.keymap.set("n", "<C-f>", function()
            api.tree.find_file({ update_root = true, open = true, focus = true, current_windown = true })
        end)

        local Event = api.events.Event
        -- 引入 java_custome_handler 模块
        local java_handler = require("snippetes.java_custom_handler")

        api.events.subscribe(Event.FileCreated, function(data)
            if data.fname:match("%.java$") then
                -- 这里的大概意思就是 创建java文件的时候 会去写一个模版进去
                java_handler.handle_java_file(data)
            end
        end)
        -- 进入vim的时候立即打开tree
        local function open_nvim_tree()
            -- open the tree
            require("nvim-tree.api").tree.open()
        end
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

        local function my_on_attach(bufnr)
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
            -- 这里删掉是因为 下面我需要使用 这个快捷键去作为打开tree的, 但是上面的default mappings中 这个快捷键被用了
            vim.keymap.del("n", "<C-t>", { buffer = bufnr })
            -- custom mappings

            -- vim.keymap.set('n', '<C-t>', api.tree.toggle,        opts('Up'))
            vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
            -- 折叠所有的
            vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))

            -- open as vsplit on current node
            local function vsplit_preview()
                local node = api.tree.get_node_under_cursor()

                if node.nodes ~= nil then
                    -- expand or collapse folder
                    api.node.open.edit()
                else
                    -- open file as vsplit
                    api.node.open.vertical()
                end

                -- Finally refocus on tree if it was lost
                api.tree.focus()
            end
            -- 这个是 如果是文件夹就展开 如果是文件就 分竖屏打开
            vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
        end

        local HEIGHT_RATIO = 0.8 -- You can change this
        local WIDTH_RATIO = 0.5 -- You can change this too
        require("nvim-tree").setup({
            on_attach = my_on_attach,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
                preserve_window_proportions = true, -- 保持窗口比例
                -- float = {
                -- 	enable = true,
                -- 	open_win_config = function()
                -- 		local screen_w = vim.opt.columns:get()
                -- 		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                -- 		local window_w = screen_w * WIDTH_RATIO
                -- 		local window_h = screen_h * HEIGHT_RATIO
                -- 		local window_w_int = math.floor(window_w)
                -- 		local window_h_int = math.floor(window_h)
                -- 		local center_x = (screen_w - window_w) / 2
                -- 		local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                -- 		return {
                -- 			border = "rounded",
                -- 			relative = "editor",
                -- 			row = center_y,
                -- 			col = center_x,
                -- 			width = window_w_int,
                -- 			height = window_h_int,
                -- 		}
                -- 	end,
                -- },
                -- width = function()
                -- 	return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                -- end,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
        })
    end,
}
