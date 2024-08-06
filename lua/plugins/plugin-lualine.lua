return {
    {
        'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
	    -- 提供了一个方法可以直接获取默认配置 可以看github详细
	    local default_config = require('lualine').get_config()
	    -- 设置主题 
	    default_config.options.theme = 'palenight'
            require('lualine').setup(default_config)
	    -- :lua print(vim.inspect(require('lualine').get_config()))
	    -- print(vim.inspect(require('lualine').get_config()))
        end
    }
}
