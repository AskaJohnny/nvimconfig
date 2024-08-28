return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup({
                icons = { expanded = "", collapsed = "", current_frame = "" },
                layouts = {
                    {
                        -- You can change the order of elements in the sidebar
                        elements = {
                            -- Provide IDs as strings or tables with "id" and "size" keys
                            {
                                id = "scopes",
                                size = 0.25, -- Can be float or integer > 1
                            },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    -- {
                    --     elements = {
                    --         { id = "console", size = 1 },
                    --     },
                    --     size = 10,
                    --     position = "bottom",
                    -- },
                },
            })

            local M = { dapui_active = false }
            local dapui_console = dap.defaults.fallback.terminal_win_cmd
            dap.defaults.fallback.terminal_win_cmd = function()
                if M.dapui_active then
                    local bufnr = dapui_console()
                    auto_close(bufnr)
                    return bufnr
                else
                    local cur_win = vim.api.nvim_get_current_win()
                    -- open terminal
                    vim.api.nvim_command("belowright 14new")
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.bo[bufnr].modifiable = false
                    vim.bo[bufnr].swapfile = false
                    vim.bo[bufnr].buftype = "nofile"
                    vim.bo[bufnr].filetype = "dap-terminal"

                    local win = vim.api.nvim_get_current_win()
                    vim.api.nvim_set_current_win(cur_win)
                    -- auto_close(bufnr)
                    return bufnr, win
                end
            end
            -- dap.defaults.fallback.terminal_win_cmd = "belowright 5new | set filetype=dap-terminal"
            -- dap.defaults.fallback.terminal_win_cmd = "belowright new | set filetype=dap-terminal"
            -- 这里想实现 根据 lsp 是哪个 是java就开启console, 是 其他的就2个都开启
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(arg)
                    local server_name = vim.lsp.get_client_by_id(arg.data.client_id).name

                    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
                    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
                    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

                    local dap, dapui = require("dap"), require("dapui")

                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        require("dapui").open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close()
                    end
                    -- nvim-dap
                    vim.api.nvim_create_user_command("DapUIOpen", function()
                        M.dapui_active = true
                        require("dapui").open()
                    end, {})
                    vim.api.nvim_create_user_command("DapUIClose", function()
                        M.dapui_active = false
                        require("dapui").close()
                    end, {})
                    vim.api.nvim_create_user_command("DapUIToggle", function()
                        M.dapui_active = not M.dapui_active
                        require("dapui").toggle()
                    end, {})

                    -- dap.listeners.before.attach.dapui_config = function()
                    --     dapui.open()
                    -- end
                    -- dap.listeners.before.launch.dapui_config = function()
                    --     dapui.open()
                    -- end
                end,
            })
        end,
    },
}
