return {
    {
        "chaozwn/im-select.nvim",
        lazy = false,
        opts = {
            default_im_select = "com.sogou.inputmethod.sogou.pinyin",
            set_previous_events = { "InsertEnter", "FocusLost" },
            set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
        },
    },
}
