return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"typescript",
				"tsx",
				"angular",
				"javascript",
				"html",
				"css",
				"json",
				"markdown",
				"bash",
				"c_sharp",
				"yaml",
				"powershell",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
