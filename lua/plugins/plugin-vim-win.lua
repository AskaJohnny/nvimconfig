return {
	{
		"dstein64/vim-win",
		config = function()
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<leader>w", ":Win<CR>", opts)
		end,
	},
}
