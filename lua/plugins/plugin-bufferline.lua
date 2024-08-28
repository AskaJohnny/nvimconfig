return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    -- mode = "buffers", -- set to "tabs" to only show tabpages instead
                    mode = "buffers", -- set to "tabs" to only show tabpages instead
                    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
                    themable = true, -- allows highlight groups to be overridden
                    numbers = "none", -- use "ordinal" | "buffer_id" | "both" if needed
                    close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
                    left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
                    middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
                    indicator = {
                        icon = "▎", -- this should be omitted if indicator style is not 'icon'
                        style = "icon", -- 'icon' | 'underline' | 'none',
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    name_formatter = function(buf)
                        -- Custom logic for buffer names
                        return buf.name
                    end,
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true, -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = false,   -- "nvim_lsp" or "coc" can be used instead
                    diagnostics_update_in_insert = false, -- only applies to coc
                    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        return "(" .. count .. ")"
                    end,
                    custom_filter = function(buf_number, buf_numbers)
                        -- Custom filtering logic
                        return true
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_watches",
                            text = "dapui_watches",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_breakpoints",
                            text = "dapui_breakpoints",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                        {
                            filetype = "dapui_scopes",
                            text = "dapui_scopes",
                            text_align = "left", -- "center" | "right"
                            separator = true,
                        },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    get_element_icon = function(element)
                        -- Custom logic to get the icon for the element
                        local icon, hl =
                            require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
                        return icon, hl
                    end,
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                    duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
                    separator_style = "slant", -- "slope" | "thick" | "thin" | { 'any', 'any' },
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                    sort_by = "insert_after_current", -- other options: 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
                },
            })
        end,
    },
}
