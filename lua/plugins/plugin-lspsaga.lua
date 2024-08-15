return {
	{
		"glepnir/lspsaga.nvim",
		config = function()
			-- 设置主题
			require("lspsaga").setup({
				lightbulb = {
					enable = false, -- 禁用灯泡提示
				},
				-- 结构 方法
				outline = {
					-- 左边窗口的宽度 默认是30
					win_width = 40,
					-- jump后 自动关闭
					close_after_jump = true,
				},
				finder = {
					left_width = 0.5,
					max_height = 0.8,
					right_width = 0.5,
				},
			})
		end,
	},
}
