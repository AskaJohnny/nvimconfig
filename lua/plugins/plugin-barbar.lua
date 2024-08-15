return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
		config = function()
			-- 定义函数来关闭其他标签
			-- 好像没有关闭其他buffer的命令 这里gpt给我生成的  关闭其他的buffer但是不关闭 NvimTree buffer , 可以通过 :lua print(vim.api.nvim_buf_get_name(0)) 打印看看 tree的buffer的名称
			function CloseOtherBuffer()
				local current = vim.api.nvim_get_current_buf()
				local buffers = vim.api.nvim_list_bufs()

				for _, buf in ipairs(buffers) do
					-- 获取缓冲区名称
					local bufname = vim.api.nvim_buf_get_name(buf)
					-- 检查缓冲区是否是 NvimTree
					if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and not string.find(bufname, "NvimTree_") then
						vim.cmd("bdelete " .. buf)
					end
				end
			end

			-- 映射快捷键来关闭其他标签
			require("barbar").setup({
				-- Set the filetypes which barbar will offset itself for
				sidebar_filetypes = {
					-- Use the default values: {event = 'BufWinLeave', text = nil}
					NvimTree = true,
					-- Or, specify the text used for the offset:
					undotree = { text = "undotree" },
					-- Or, specify the event which the sidebar executes when leaving:
					["neo-tree"] = { event = "BufWipeout" },
					-- Or, specify both
					Outline = { event = "BufWinLeave", text = "symbols-outline" },
				},
				-- -- 当关闭了当前的buf 的时候 如果有其他的buf 则聚焦从left 开始
				-- Valid options are 'left' (the default), 'previous', and 'right'
				focus_on_close = "left",
				-- sorting options
				sort = {
					-- tells barbar to ignore case differences while sorting buffers
					ignore_case = true,
				},
			})
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			-- 要注意 iterm2 的 Profiles -> Default -> Keys -> Left Option key : 选择Esc+ (好像是代表alt)
			-- 我的option + . 以前是 欧陆词典的 翻译快捷 所以导致冲突 然后给欧陆的翻译快捷键换掉了
			map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
			-- 下面这2个本来是想用的 但是因为 好像和 sharkd 快捷键冲突 就是配和yabai 的那个 就算了
			-- map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
			-- map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)
			-- Re-order to previous/next
			map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
			map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
			-- Goto buffer in position...
			map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
			map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
			map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
			map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
			map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
			map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
			map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
			map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
			map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
			map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
			-- Pin/unpin buffer
			map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
			-- Close buffer
			map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
			-- Clous other buffer
			map("n", "<A-o>", ":lua CloseOtherBuffer()<CR>", opts)
		end,
	},
}
