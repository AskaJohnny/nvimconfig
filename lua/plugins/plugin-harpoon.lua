return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            vim.keymap.set("n", "<leader>a", function()
                local list = harpoon:list()
                local added_item = list:add()
                print(vim.inspect(added_item))
                local last_item = list.items[#list.items]
                if last_item and last_item.value then
                    require("notify")("Added to Harpoon: " .. last_item.value)
                else
                    require("notify")("Failed to Harpoon: " .. last_item.value)
                end
            end)

            -- vim.keymap.set("n", "<C-h>", function()
            --     harpoon:list():select(1)
            -- end)
            -- vim.keymap.set("n", "<C-t>", function()
            --     harpoon:list():select(2)
            -- end)
            -- vim.keymap.set("n", "<C-n>", function()
            --     harpoon:list():select(3)
            -- end)
            -- vim.keymap.set("n", "<C-s>", function()
            --     harpoon:list():select(4)
            -- end)
            --
            -- -- Toggle previous & next buffers stored within Harpoon list
            -- vim.keymap.set("n", "<C-S-P>", function()
            --     harpoon:list():prev()
            -- end)
            -- vim.keymap.set("n", "<C-S-N>", function()
            --     harpoon:list():next()
            -- end)

            --从这个地方 找到了 关于可以 telescope 删除harpoon功能 https://github.com/ThePrimeagen/harpoon/issues/499
            local function toggle_telescope(harpoon_files)
                local finder = function()
                    local paths = {}
                    for _, item in ipairs(harpoon_files.items) do
                        table.insert(paths, item.value)
                    end

                    return require("telescope.finders").new_table({
                        results = paths,
                    })
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = finder(),
                        previewer = false,
                        sorter = require("telescope.config").values.generic_sorter({}),
                        layout_config = {
                            height = 0.4,
                            width = 0.5,
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                        attach_mappings = function(prompt_bufnr, map)
                            map("i", "<C-d>", function()
                                local state = require("telescope.actions.state")
                                local selected_entry = state.get_selected_entry()
                                local current_picker = state.get_current_picker(prompt_bufnr)
                                local deleted_item = harpoon_files.items[selected_entry.index]
                                table.remove(harpoon_files.items, selected_entry.index)
                                current_picker:refresh(finder())
                                require("notify")("Deleted from Harpoon: " .. deleted_item.value)
                            end)
                            return true
                        end,
                    })
                    :find()
            end
            vim.keymap.set("n", "<C-e>", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Open harpoon window" })

            vim.api.nvim_create_autocmd({ "BufLeave", "ExitPre", "BufDelete" }, {
                pattern = "*",
                callback = function()
                    local filename = vim.fn.expand("%:p:.")
                    local harpoon_marks = harpoon:list().items
                    for _, mark in ipairs(harpoon_marks) do
                        if mark.value == filename then
                            mark.context.row = vim.fn.line(".")
                            mark.context.col = vim.fn.col(".")
                            return
                        end
                    end
                end,
            })

            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = "*",
                callback = function()
                    local filename = vim.fn.expand("%:p:.")
                    local harpoon_marks = harpoon:list().items
                    for _, mark in ipairs(harpoon_marks) do
                        if mark.value == filename and mark.context then
                            local row = mark.context.row or 1
                            local col = mark.context.col or 1
                            vim.api.nvim_win_set_cursor(0, { row, col })
                            return
                        end
                    end
                end,
            })
        end,
    },
}
