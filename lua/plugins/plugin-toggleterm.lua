return {
	{
		"akinsho/toggleterm.nvim",
		tag = "*",
		version = "*",
		--config = true,
		config = function()
			-- 配置 ToggleTerm 并确保正确设置键映射
			require("toggleterm").setup({
				open_mapping = [[<leader>t]], -- 映射 <leader>t 来打开 ToggleTerm
				hide_numbers = true, -- 隐藏 ToggleTerm 缓冲区中的行号
				shade_filetypes = {},
				autochdir = false, -- Neovim 更改目录时，终端将在下次打开时更改目录
				direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float',
				float_opts = {
					border = "curved", -- 可以选择 'single', 'double', 'shadow', 'curved' 等
					width = function()
						return math.floor(vim.o.columns * 0.8)
					end,
					height = function()
						return math.floor(vim.o.lines * 0.8)
					end,
					row = function()
						return math.floor((vim.o.lines - (vim.o.lines * 0.8)) / 2)
					end,
					col = function()
						return math.floor((vim.o.columns - (vim.o.columns * 0.8)) / 2)
					end,
					winblend = 6, -- 窗口透明度
					zindex = 50, -- 窗口层级
					title_pos = "left", -- 标题的位置：'left', 'center', 'right'
				},
			})
			-- 创建一个 LazyGit 终端实例
			local lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = {
					-- width = vim.o.columns,
					-- height = vim.o.lines,

					border = "curved", -- 你可以选择 'single', 'double', 'shadow', 'curved' 等
					-- width = vim.o.columns,
					-- height = vim.o.lines,
					width = function()
						return math.floor(vim.o.columns * 0.9)
					end,
					height = function()
						return math.floor(vim.o.lines * 0.9)
					end,
					row = function()
						return math.floor((vim.o.lines - (vim.o.lines * 0.9)) / 2)
					end,
					col = function()
						return math.floor((vim.o.columns - (vim.o.columns * 0.9)) / 2)
					end,
					winblend = 6, -- 窗口透明度
					zindex = 50, -- 窗口层级
					title_pos = "left", -- 标题的位置：'left', 'center', 'right'
				},
				winbar = {
					enabled = true,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
				on_open = function(term)
					-- 在终端打开时设置终端名称
					term.name = "LazyGit"
				end,
			})
			---- 开启一个 lazygit 使用toggleterm
			vim.keymap.set("n", "<leader>lg", function()
				lazygit:toggle()
			end)
			-- 效果就是终端模式下也可以快速地关闭, 否则还需jk or ESC   映射在终端模式下的快捷键，退出插入模式并执行 <leader>lg
			vim.keymap.set("t", "<leader>lg", function()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", false)
				lazygit:toggle()
			end, { noremap = true, silent = true })
		end,
        -- 这里其实没用了 已经移动到上面了
		opts = {
			open_mapping = [[<leader>t]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
			direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float',
			float_opts = {
				border = "curved", -- 你可以选择 'single', 'double', 'shadow', 'curved' 等
				width = function()
					return math.floor(vim.o.columns * 0.8)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.8)
				end,
				row = function()
					return math.floor((vim.o.lines - (vim.o.lines * 0.8)) / 2)
				end,
				col = function()
					return math.floor((vim.o.columns - (vim.o.columns * 0.8)) / 2)
				end,
				winblend = 6, -- 窗口透明度
				zindex = 50, -- 窗口层级
				title_pos = "left", -- 标题的位置：'left', 'center', 'right'
			},
			-- winbar = {
			--     enabled = true,       -- 启用 winbar
			--     name_formatter = function(term) -- term: Terminal
			--         return "Terminal: " .. "2222222222222222222" -- 自定义显示内容
			--     end,
			-- },
		},
	},
}
