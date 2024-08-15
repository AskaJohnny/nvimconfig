return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			dap.set_log_level("TRACE")
			--dap.defaults.fallback.terminal_win_cmd = '50vsplit new'
			-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
			--			dap.defaults.fallback.terminal_win_cmd = "tabnew"
			dap.configurations.java = {
				{
					-- You need to extend the classPath to list your dependencies.
					-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
					-- 这个不能配置 !!!
					-- classPaths = {
					-- },
					-- If using multi-module projects, remove otherwise.
					-- projectName = "ems-lindorm",
					projectName = "ems-lindorm",
					javaExec = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
					-- mainClass = "${file}",
					mainClass = "com.wifochina.LindormApplication",
					-- If using the JDK9+ module system, this needs to be extended
					-- `nvim-jdtls` would automatically populate this property
					modulePaths = {},
					name = "Launch ems-lindorm Application",
					request = "launch",
					type = "java",
					console = "externalTerminal",
					-- https://github.com/mfussenegger/nvim-dap/discussions/656 这个里面介绍一下 怎么使用外部的 terminal + tmux 里面提到要把这个加上
					shortenCommandLine = "argfile",
				},
			}
			dap.defaults.fallback.external_terminal = {
				command = "tmux",
				-- args = { "split-window", "-h" }, -- '-h' 参数用于创建垂直分割（%）窗口
				-- args = { "split-pane", "-c", "Users/johnny/java/newworkspace/ems-server", "-l", "15" },
				args = { "split-pane", "-l", "15", "-d" },
				-- args = { "split-pane", "-v", "-p", "30" },
			}

			--			dap.defaults.fallback.force_external_terminal = true
			--dap.defaults.fallback.focus_terminal = true
			local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
			-- local namespace = vim.api.nvim_create_namespace("dap-hlng")
			-- vim.api.nvim_set_hl(namespace, "DapBreakpoint", { fg = "#eaeaeb", bg = "#ffffff" })
			-- vim.api.nvim_set_hl(namespace, "DapLogPoint", { fg = "#eaeaeb", bg = "#ffffff" })
			-- vim.api.nvim_set_hl(namespace, "DapStopped", { fg = "#eaeaeb", bg = "#ffffff" })

			-- vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
			-- vim.api.nvim_set_hl(0, "blue", { fg = "#FFFFFF" })
			-- vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
			-- vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
			-- vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "🟡", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "❌", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "➡️", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "💬", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			require("config.dap.keymap")
		end,
	},
}
