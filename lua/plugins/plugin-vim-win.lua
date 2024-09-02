return {
    {
        "dstein64/vim-win",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>w", ":Win<CR>", opts)
            -- 在 Vim 的 `VimEnter` 事件之后设置颜色，以确保插件已加载
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    -- 将 WinActive 颜色链接到 Error 颜色
                    vim.cmd("highlight link WinActive Error")
                    -- 自定义 WinInactive 的颜色
                    -- vim.cmd("highlight WinInactive term=bold ctermfg=12 ctermbg=159 guifg=Blue guibg=LightCyan")
                end,
            })
        end,
    },
}
