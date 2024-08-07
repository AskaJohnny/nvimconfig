return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        -- config = true,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
        -- If you want insert `(` after select function or method item
        config = function()
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local npairs = require('nvim-autopairs')
            -- fast warp 快捷键 alt + e 就是<M-e>
            npairs.setup({
                fast_wrap = {},
            })
            -- fast warp custom
            --            npairs.setup({
            --                fast_wrap = {
            --                    map = '<M-e>',
            --                    chars = { '{', '[', '(', '"', "'" },
            --                    pattern = [=[[%'%"%>%]%)%}%,]]=],
            --                    end_key = '$',
            --                    before_key = 'h',
            --                    after_key = 'l',
            --                    cursor_pos_before = true,
            --                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
            --                    manual_position = true,
            --                    highlight = 'Search',
            --                    highlight_grey = 'Comment'
            --                },
            --            })
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
            require('nvim-autopairs').setup({
                enable_check_bracket_line = false
            })
        end

    }
}
