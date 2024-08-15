return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local user_config = {
				controls = {
					element = "repl",
					enabled = false,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = "",
				},
				layouts = {
					-- {
					--     elements = { { id = "scopes", size = 0.25, }, { id = "breakpoints", size = 0.25,
					--         },
					--         -- {
					--         --     id = "stacks",
					--         --     size = 0.25,
					--         -- },
					--         {
					--             id = "watches",
					--             size = 0.25,
					--         },
					--     },
					--     position = "left",
					--     size = 40,
					-- },
					-- {
					--     elements = {
					--         {
					--             id = "console",
					--             size = 1,
					--         },
					--     },
					--     position = "bottom",
					--     size = 10,
					-- },
				},
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
				render = {
					indent = 1,
					max_value_lines = 100,
				},
			}
			local layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						-- {
						--     id = "stacks",
						--     size = 0.25,
						-- },
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				-- {
				--     elements = {
				--         {
				--             id = "console",
				--             size = 0.5,
				--         },
				--     },
				--     position = "bottom",
				--     size = 10,
				-- },
			}

			-- 这里想实现 根据 lsp 是哪个 是java就开启console, 是 其他的就2个都开启
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(arg)
					local server_name = vim.lsp.get_client_by_id(arg.data.client_id).name
					if server_name == "jdtls" then
						-- table.insert(layouts, {
						--     elements = {
						--         {
						--             id = "console",
						--             size = 1,
						--         },
						--     },
						--     position = "bottom",
						--     size = 10,
						-- })
					elseif server_name == "kotlin_language_server" then
						table.insert(layouts, {
							elements = {
								{
									id = "repl",
									size = 1,
								},
							},
							position = "bottom",
							size = 10,
						})
					else
						table.insert(layouts, {
							elements = {
								{
									id = "repl",
									size = 0.5,
								},
								{
									id = "console",
									size = 0.5,
								},
							},
							position = "bottom",
							size = 10,
						})
					end
					-- user_config["layouts"] = layouts
					require("dapui").setup(user_config)

					vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
					vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
					vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

					local dap, dapui = require("dap"), require("dapui")

					dap.listeners.before.attach.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.launch.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated.dapui_config = function()
						print("terminate")
						if dap.session().exited == true then
							dapui.close()
						end
					end
					dap.listeners.before.event_exited.dapui_config = function()
						print("exited")
						if dap.session().exited == true then
							dapui.close()
						end
					end
				end,
			})
		end,
	},
}
