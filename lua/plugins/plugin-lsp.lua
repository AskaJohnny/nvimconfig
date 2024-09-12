return {
    {
        "git@github.com:williamboman/mason-lspconfig.nvim.git",
        config = function()
            require("mason-lspconfig").setup({
                -- 确保安装，根据需要填写
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "yamlls",
                    "gopls",
                    "jdtls",
                    "html",
                    "tsserver",
                    --"google-java-format",
                    "sqls",
                    "jsonls",
                    "volar",
                    "vtsls",
                    "lemminx",
                },
            })
        end,
    },
    {
        "git@github.com:williamboman/mason.nvim.git",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry", -- pinned version
                },
                github = {
                    ---@since 1.0.0
                    -- The template URL to use when downloading assets from GitHub.
                    -- The placeholders are the following (in order):
                    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
                    -- 2. The release version (e.g. "v0.3.0")
                    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
                    download_url_template = "https://github.com/%s/releases/download/%s/%s",
                },

                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {

        "git@github.com:neovim/nvim-lspconfig.git",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- vim.lsp.set_log_level("debug")
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }

                local map = vim.api.nvim_set_keymap
                local opt = { noremap = true, silent = true }
                map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
                map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
                -- glance
                map("n", "gi", "<cmd>Glance implementations<CR>", opt)
                map("n", "gr", "<cmd>Glance references<CR>", opt)
                map("n", "gd", "<cmd>Glance definitions<CR>", opt)

                -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts)

                -- 给个通知
                --
                require("notify")("LSP [" .. client.name .. "] 已连接", "info", {
                    timeout = 100,
                })
            end

            -- 这里开始是 配置各个语言的 lsp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- vim.lsp.set_log_level("debug")
            require("lspconfig").lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            local util = require("lspconfig.util")
            require("lspconfig").pyright.setup({
                root_dir = util.root_pattern(".git"),
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- html
            require("lspconfig").html.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- jsonls 和 yamlls 依赖 利用了 schemastore 这个 里面包含了很多schema 比如  package.json  docker-compose 等等
            -- https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json  , 这个 catalog 可以查询到包含的所有
            require("lspconfig").jsonls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            require("lspconfig").sqls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").lemminx.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- 不知道有什么区别 这个是把volar和ts分开
            -- local lspconfig = require("lspconfig")
            -- lspconfig.tsserver.setup({
            --     on_attach = on_attach,
            --     init_options = {
            --         plugins = {
            --             {
            --                 name = "@vue/typescript-plugin",
            --                 location = "/Users/johnny/.npm-global/lib/node_modules/@vue/language-server",
            --                 languages = { "vue" },
            --             },
            --         },
            --     },
            -- })
            -- lspconfig.volar.setup({
            --     on_attach = on_attach,
            --     init_options = {
            --         vue = {
            --             hybridMode = false,
            --         },
            --     },
            -- })

            require("lspconfig").volar.setup({
                -- capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
                typescript = {
                    tsdk = "/Users/johnny/.npm-global/lib/node_modules/typescript/lib",
                    -- Alternative location if installed as root:
                    -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
                },
            })

            -- require("lspconfig").vtsls.setup({
            --              on_attach = on_attach,
            --              capabilities = capabilities,
            -- 	filetypes = {
            -- 		-- "javascript",
            -- 		-- "javascriptreact",
            -- 		-- "javascript.jsx",
            -- 		-- "typescript",
            -- 		-- "typescriptreact",
            -- 		-- "typescript.tsx",
            --                  "vue"
            -- 	},
            --
            -- 	settings = {
            -- 		complete_function_calls = true,
            -- 		vtsls = {
            -- 			enableMoveToFileCodeAction = true,
            -- 			autoUseWorkspaceTsdk = true,
            -- 			experimental = {
            -- 				completion = {
            -- 					enableServerSideFuzzyMatch = true,
            -- 				},
            -- 			},
            -- 		},
            -- 		javascript = {
            -- 			updateImportsOnFileMove = { enabled = "always" },
            -- 			inlayHints = {
            -- 				parameterNames = { enabled = "literals" },
            -- 				parameterTypes = { enabled = true },
            -- 				variableTypes = { enabled = true },
            -- 				propertyDeclarationTypes = { enabled = true },
            -- 				functionLikeReturnTypes = { enabled = true },
            -- 				enumMemberValues = { enabled = true },
            -- 			},
            -- 		},
            -- 	},
            -- })

            local sql_config = require("../config/sqlconfig/mysql_config")
            require("lspconfig").sqls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    require("sqls").on_attach(client, bufnr) -- require sqls.nvim
                    -- 自动调整 sqls_output 缓冲区的大小
                    vim.api.nvim_create_augroup("AdjustSqlsOutputHeight", { clear = true })
                    -- 自动命令监听 FileType 为 sqls_output 的事件
                    vim.api.nvim_create_autocmd("FileType", {
                        group = "AdjustSqlsOutputHeight",
                        pattern = "sqls_output",
                        callback = function()
                            -- 获取当前窗口 ID
                            local win_id = vim.api.nvim_get_current_win()
                            -- 设置窗口高度
                            vim.api.nvim_win_set_height(win_id, 30) -- 将高度设置为 20 行，可根据需要调整
                        end,
                    })
                end,
                settings = {
                    sqls = {
                        connections = {
                            sql_config.blogs_new_db,
                            sql_config.ems_dev_db,
                            -- {
                            --     driver = 'mysql',
                            --     dataSourceName = 'root:root123456@tcp(127.0.0.1:3306)/blogs_new',
                            -- },
                        },
                    },
                },
            })
            require("lspconfig").yamlls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        format = {
                            enable = true,
                            singleQuote = true,
                            printWidth = 120,
                        },
                        hover = true,
                        completion = true,
                        validate = true,
                        schemas = require("schemastore").yaml.schemas({
                            extra = {
                                {
                                    description = "kubernetes yaml store",
                                    fileMatch = { "**/kubernetes.yaml" },
                                    name = "kubernetes.yaml",
                                    -- 注意这里使用的是 master-local 的 我换个其他的不行
                                    -- https://github.com/yannh/kubernetes-json-schema 这个是github地址 我是把这个地址clone下来然后 只保留了 master-local部分
                                    -- master-standalone-strict 和 master-standalone都不能用 没研究 这个 local可以用  因为如果选用远程的可能受网络影响
                                    url = "file:///Users/johnny/.config/kubernetes-json-schema/master-local/all.json",
                                },
                            },
                        }),
                    },
                },
            })
        end,
    },
}
