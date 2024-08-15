return {
    {
        'mfussenegger/nvim-jdtls',
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require('jdtls')
        end
    }
}
