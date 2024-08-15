return {
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            -- { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            -- { "<c-l>", "<cmd>NvimTreeToggle<CR><cmd><C-U>TmuxNavigateRight<CR>", { noremap = true, silent = true } },

            {
                "<c-l>",
                "<cmd>lua vim.cmd('NvimTreeToggle'); vim.cmd('TmuxNavigateRight')<CR>",
                { noremap = true, silent = true },
            },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
}
