local dap = require("dap")
local dapui = require("dapui")
local wk = require("which-key")
local widgets = require("dap.ui.widgets")

local M = {}


vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(arg)
        local buffer = arg.buf
        local server_name = vim.lsp.get_client_by_id(arg.data.client_id).name

        M.on_attach(server_name, buffer)
    end,
})

function M.on_attach(ls, buffer)
    M.setup_dap_keymaps(buffer)
    -- language specific overrides
    if ls.name == "jdtls" then
        M.setup_java_keymaps(buffer)
    end
end

function M.setup_dap_keymaps(buffer)
    wk.register({
        name = "Debug",
        e = {
            ["t"] = { dap.toggle_breakpoint, "Toggle breakpoint" },

            ["r"] = { dap.restart, "Restart" },
            ["a"] = { dap.run_last, "Run last" },

            ["m"] = { dap.step_out, "Step out" },
            ["n"] = { dap.step_over, "Step over" },
            ["e"] = { dap.step_into, "Step into" },
            ["i"] = {
                function()
                    dap.continue()
                    require("nvim-tree.api").tree.close()
                    _G.tree_status_open = false
                end,
                "Continue debug",
            },

            ["l"] = { dap.up, "Go up in call stack" },
            ["u"] = { dap.down, "Go down in call stack" },

            ["I"] = { dap.terminate, "Terminate" },

            --			["h"] = { widgets.hover, "Hover" },
            --["s"] = { M.inspect_scope, "Inspect scope" },
            ["o"] = { dap.repl.open, "Open repl" },
            ["c"] = { dapui.close, "Dapui Close" },
            ["1"] = {
                function()
                    dap.run(dap.configurations.java[1])
                end,
                "Run first debug config",
            },
            -- 绑定快捷键 <leader>ds 打开 scopes 的浮动窗口
            ["s"] = {
                function()
                    dapui.float_element("scopes", {
                        width = 80,
                        height = 20,
                        enter = true,
                        position = { row = 2, col = 5 },
                        relative = "editor",
                    })
                end,
                "Open scopes in floating window",
            },

            -- 绑定快捷键 <leader>dk 打开 stacks 的浮动窗口
            ["k"] = {
                function()
                    dapui.float_element("stacks", {
                        width = 60,
                        height = 15,
                        enter = true,
                        position = { row = 2, col = 5 },
                        relative = "editor",
                    })
                end,
                "Open stacks in floating window",
            },

            -- 绑定快捷键 <leader>dw 打开 watches 的浮动窗口
            ["w"] = {
                function()
                    dapui.float_element("watches", {
                        width = 80,
                        height = 20,
                        enter = true,
                        position = { row = 3, col = 5 },
                        relative = "editor",
                    })
                end,
                "Open watches in floating window",
            },

            -- 绑定快捷键 <leader>db 打开 breakpoints 的浮动窗口
            ["b"] = {
                function()
                    dapui.float_element("breakpoints", {
                        width = 50,
                        height = 15,
                        enter = true,
                        position = { row = 2, col = 5 },
                        relative = "editor",
                    })
                end,
                "Open breakpoints in floating window",
            },
        },
    }, { prefix = "<leader>", mode = "n", buffer = buffer })

    wk.register({
        name = "Debug",
        e = {
            ["i"] = { widgets.hover, "Evaluate selected" },
        },
    }, { prefix = "<leader>", mode = "v", buffer = buffer })
end

function M.setup_java_keymaps(buffer)
    wk.register({
        name = "Debug",
        e = {
            ["i"] = { JavaDapActions.continue, "Continue java debug" },
        },
    }, { prefix = "<leader>", buffer = buffer })
end

function M.inspect_scope()
    widgets.centered_float(widgets.scopes).open()
end

return M
