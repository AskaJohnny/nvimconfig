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
                    --"google-java-format",
                    "jsonls"
                },
            })
        end
    },
    {
        "git@github.com:williamboman/mason.nvim.git",
        config = function()
            require('mason').setup({
                registries = {
                    "github:mason-org/mason-registry" -- pinned version
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
                        package_uninstalled = "✗"
                    }
                }
            })
        end
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
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts)
            end


            -- 这里开始是 配置各个语言的 lsp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("lspconfig").lua_ls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            local util = require 'lspconfig.util'
            require("lspconfig").pyright.setup {
                root_dir = util.root_pattern('.git'),
                capabilities = capabilities,
                on_attach = on_attach,
            }

            require("lspconfig").html.setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- jsonls 和 yamlls 依赖 利用了 schemastore 这个 里面包含了很多schema 比如  package.json  docker-compose 等等
            -- https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json  , 这个 catalog 可以查询到包含的所有
            require('lspconfig').jsonls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            }
            require('lspconfig').yamlls.setup {
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
                        schemas = require('schemastore').yaml.schemas({
                            extra = {
                                {
                                    description = 'kubernetes yaml store',
                                    fileMatch = { '**/kubernetes.yaml' },
                                    name = 'kubernetes.yaml',
                                    -- 注意这里使用的是 master-local 的 我换个其他的不行
                                    -- https://github.com/yannh/kubernetes-json-schema 这个是github地址 我是把这个地址clone下来然后 只保留了 master-local部分
                                    -- master-standalone-strict 和 master-standalone都不能用 没研究 这个 local可以用  因为如果选用远程的可能受网络影响
                                    url = 'file:///Users/johnny/.config/kubernetes-json-schema/master-local/all.json',
                                },
                            },
                        }),
                    },
                },
            }
        end
    }


}
