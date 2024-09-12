return {
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                stages = "slide",
                max_width = 30,
                -- 设置通知窗口的最小高度为1行
                min_height = 1,
                timeout = 5000,
            })
        end,
    },
}
