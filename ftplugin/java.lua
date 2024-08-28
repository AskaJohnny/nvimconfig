local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/java/newworkspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH
---- "/Users/johnny/.local/share/nvim/lsp/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
local config = {
    autostart = true,
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:/Users/johnny/.config/nvim/ftplugin/lombok-1.18.32.jar",
        "-jar",
        "/Users/johnny/.local/share/nvim/lsp/jdt-language-server-1.38.0/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        "-configuration",
        "/Users/johnny/.local/share/nvim/lsp/jdt-language-server-1.38.0/config_mac_arm",
        "-data",
        workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
    settings = {
        java = {},
    },
    init_options = {
        -- 禁用 jdtls 自带的格式化功能
        formattingProvider = false,
        bundles = {
            vim.fn.glob(
                "/Users/johnny/.local/share/nvim/lsp/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
                1
            ),
        },
    },
}
config["on_attach"] = function(client, bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    --    require('jdtls.dap').setup_dap_main_class_configs()
    require("jdtls.dap").setup_dap_main_class_configs()
end
require("jdtls").start_or_attach(config)

--local dap = require('dap')
--dap.configurations.java = {
--{
---- You need to extend the classPath to list your dependencies.
---- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
--classPaths = {
--},
---- If using multi-module projects, remove otherwise.
----projectName = "dempspring",
--javaExec = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
--mainClass = "${file}",
---- If using the JDK9+ module system, this needs to be extended
---- `nvim-jdtls` would automatically populate this property
--modulePaths = {
--},
--name = "Launch Java Project"  ,
--request = "launch",
--type = "java"
--},
--}
--require('/Users/johnny/.local/share/nvim/lsp/jdt-language-server/workspace/folder/demospring/dap.lua')
local current_buff = vim.api.nvim_get_current_buf()
local java_on_attach = function(client, bufnr)
    --    print(client)
    -- client.server_capabilities.documentFormattingProvider = false
    -- 在语言服务器附加到当前缓冲区之后
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    --    require("jdtls").setup_dap { hotcodereplace = "auto" }
    --require('jdtls.dap').setup_dap_main_class_configs()
    --Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    -- buf_set_keymap("n", "<A-m>", "<cmd>Lspsaga rename<CR>", opts)
    -- buf_set_keymap("n", "<leader>ck", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
    -- buf_set_keymap("n", "<leader>co", "<cmd>Lspsaga outline<CR>", opts)
    --buf_set_keymap("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opts)
    --buf_set_keymap("t", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opts)

    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    --重命名
    --buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --智能提醒，比如：自动导包 已经用lspsaga里的功能替换了
    -- buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    --buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    --代码格式化
    -- buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async=true}, function() vim.cmd('nohlsearch') end)<CR> , opts),
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --自动导入全部缺失的包，自动删除多余的未用到的包
    -- buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- --引入局部变量的函数 function to introduce a local variable
    -- --buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    -- buf_set_keymap("n", "<A-CR>", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    -- buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    -- --function to extract a constant
    -- buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    -- buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    -- --将一段代码提取成一个额外的函数function to extract a block of code into a method
    -- buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
    -- Java specific
    --
    -- buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    -- buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    -- buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    -- buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    -- buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- 代码保存自动格式化formatting
    --vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]

    buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    local wk = require("which-key")

    wk.register({
        ["<leader>d"] = {
            name = "Java",
            i = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
            t = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
            n = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Nearest Method" },
            e = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
        },
    }, { mode = "n", buffer = bufnr })

    wk.register({
        ["<leader>de"] = {
            "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
            "Extract Variable",
        },
        ["<leader>dm"] = {
            "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
            "Extract Method",
        },
    }, { mode = "v", buffer = bufnr })
end
java_on_attach(nil, current_buff)
