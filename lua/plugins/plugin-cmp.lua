local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind-nvim",
    },
}

M.config = function()
    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")

    local cmp = require("cmp")
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    -- setup() is also available as an alias
    require("lspkind").init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = "symbol_text",

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = "codicons",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
            Text = "󰉿 Text",
            Method = "󰆧 Method",
            Function = "󰊕 Function",
            Constructor = " Constructor",
            Field = "󰜢 Field",
            Variable = "󰀫 Variable",
            Class = "󰠱 Class",
            Interface = " Interface",
            Module = " Module",
            Property = "󰜢 Property",
            Unit = "󰑭 Unit",
            Value = "󰎠 Value",
            Enum = " Enum",
            Keyword = "󰌋 Keyword",
            Snippet = " Snippet",
            Color = "󰏘 Color",
            File = "󰈙 File",
            Reference = "󰈇 Reference",
            Folder = "󰉋 Folder",
            EnumMember = " EnumMember",
            Constant = "󰏿 Constant",
            Struct = "󰙅 Struct",
            Event = " Event",
            Operator = "󰆕 Operator",
            TypeParameter = " TypeParameter",
        },
    })
    local lspkind = require("lspkind")

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        -- window = {
        --     -- completion = cmp.config.window.bordered(),
        --     -- documentation = cmp.config.window.bordered(),
        -- },
        window = {
            completion = cmp.config.window.bordered({
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            }),
            documentation = cmp.config.window.bordered({
                border = "rounded",
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
            }),
        },

        mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            --            ["<Tab>"] = cmp.mapping(function(fallback)
            --                if cmp.visible() then
            --                    if #cmp.get_entries() == 1 then
            --                        cmp.confirm({ select = true })
            --                    else
            --                        cmp.select_next_item()
            --                    end
            --                    --[[ Replace with your snippet engine (see above sections on this page)
            --      elseif snippy.can_expand_or_advance() then
            --        snippy.expand_or_advance() ]]
            --                elseif has_words_before() then
            --                    cmp.complete()
            --                    if #cmp.get_entries() == 1 then
            --                        cmp.confirm({ select = true })
            --                    end
            --                else
            --                    fallback()
            --                end
            --            end, { "i", "s" }),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    else
                        cmp.select_next_item()
                    end
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                elseif has_words_before() then
                    cmp.complete()
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    end
                else
                    fallback()
                end
            end, { "i", "s" }),
            -- ["<Tab>"] = cmp.mapping(function(fallback)
            -- 	if cmp.visible() then
            -- 		cmp.select_next_item()
            -- 	elseif luasnip.locally_jumpable(1) then
            -- 		luasnip.jump(1)
            -- 	else
            -- 		fallback()
            -- 	end
            -- end, { "i", "s" }),
            --            ["<Tab>"] = cmp.mapping(function(fallback)
            --                if cmp.visible() then
            --                    cmp.select_next_item()
            --                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            --                    -- that way you will only jump inside the snippet region
            --                elseif luasnip.expand_or_jumpable() then
            --                    luasnip.expand_or_jump()
            --                elseif has_words_before() then
            --                    cmp.complete()
            --                else
            --                    fallback()
            --                end
            --            end, { "i", "s" }),
            --
            --            ["<S-Tab>"] = cmp.mapping(function(fallback)
            --                if cmp.visible() then
            --                    cmp.select_prev_item()
            --                elseif luasnip.jumpable(-1) then
            --                    luasnip.jump(-1)
            --                else
            --                    fallback()
            --                end
            --            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                    -- 过滤掉类型为 'Text' 的候选项
                    if ctx.filetype == "java" then
                        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
                    elseif ctx.filetype ~= "vue" then
                        return true
                    end
                    local cursor_before_line = ctx.cursor_before_line
                    -- For events
                    if cursor_before_line:sub(-1) == "@" then
                        return entry.completion_item.label:match("^@")
                        -- For props also exclude events with `:on-` prefix
                    elseif cursor_before_line:sub(-1) == ":" then
                        return entry.completion_item.label:match("^:")
                            and not entry.completion_item.label:match("^:on%-")
                    else
                        return true
                    end
                end,
            },
            -- { name = "nvim_lua" },
            {
                name = "luasnip",
            }, -- For luasnip users.
            -- { name = "orgmode" },
        }, {
            -- { name = "buffer" },
            { name = "path" },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol", -- show only symbol annotations
                maxwidth = 55, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                -- The function below will be called before any actual modifications from lspkind
                -- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    -- print(vim_item.kind)
                    -- vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
                    -- -- 检查显示的内容
                    -- -- vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                    -- vim_item.menu = string.format("[%s]", entry.source.name:upper())

                    -- local icon = lspkind.presets.default[vim_item.kind]
                    -- if icon then
                    -- 	print(icon)
                    -- 	vim_item.kind = icon
                    -- else
                    -- 	print(vim_item.kind)
                    -- 	vim_item.kind = vim_item.kind -- 如果没有图标，则仅显示类型
                    -- end
                    --				vim_item.kind = string.format("%s %s", vim_item.kind, vim_item.kind)
                    vim_item.menu = string.format("[%s]", entry.source.name:upper())

                    return vim_item
                end,
            }),
        },
    })
    --这一段是我测试的 大概就是这样使用 luasnip的, 但是我会去使用 frendly snip 结合 vscode的snip那种风格 不会写这种 看不懂的
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    ls.add_snippets("all", {
        s("ssn", {
            t("function "),
            i(1, "name"),
            t("("),
            i(2, "params"),
            t(")"),
            t({ "", "\t" }),
            i(0),
            t({ "", "end" }),
        }),
    })

    -- require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

return M
