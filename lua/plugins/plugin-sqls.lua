return {
    {
        "nanotee/sqls.nvim",
        config = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>sq"] = {
                    name = "sqls", -- 将所有 hunk 相关的操作放在一个组里
                    -- 暂且没有配置 prev的 p 被占用了
                    c = { "<Cmd>SqlsSwitchConnection<CR>", "SqlsSwitchConnection" },
                    e = { "<Cmd>SqlsExecuteQuery<CR>", "SqlsExecuteQuery" },
                },
            }, { buffer = bufnr })
        end,
    },
}
