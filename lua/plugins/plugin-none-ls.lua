return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.completion.spell,
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--safe" },
                    }),
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.google_java_format.with({
                        extra_args = { "--aosp" },
                    }),
                    null_ls.builtins.diagnostics.checkstyle.with({
                        command = "/opt/homebrew/bin/checkstyle2",
                        -- 这里覆盖一下 原本的默认配置 Args: { "-f", "sarif", "$ROOT" } 默认配置里面有一个 $ROOT 把整个项目都进行 checkstyle 了 导致超时一开始错误, 然后我加了timeout
                        -- timeout生效了 但是可能是返回的json 太大 导致 null-ls接受不了 还是啥原因不清楚,现在只 checkstyle当前的buf文件
                        args = {
                            "-f",
                            "sarif",
                            -- "$ROOT",
                            "-c",
                            "/Users/johnny/.config/nvim/ftplugin/alibaba_checks2.xml",
                            "$FILENAME",
                        },
                        timeout = 50000, -- 可以根据需要调整超时时间
                    }),
                    -- null_ls.builtins.diagnostics.checkstyle.with({
                    --     extra_args = { "-c", "/Users/johnny/.config/nvim/ftplugin/alibaba_checks2.xml" },
                    -- }),
                    -- null_ls.builtins.diagnostics.checkstyle.with({
                    --     command = "java",
                    --     extra_args = {
                    --         "-jar",
                    --         "/Users/johnny/Downloads/checkstyle-10.17.0-all.jar",
                    --         "-c",
                    --         "/Users/johnny/.config/nvim/ftplugin/alibaba_checks2.xml",
                    --         "$FILENAME",
                    --     },
                    -- }),
                },
            })
            --[[ require("lspconfig")["null-ls"].setup({
                sources = {
                    null_ls.builtins.formatting.prettierd
                }
            }) ]]
        end,
    },
}
