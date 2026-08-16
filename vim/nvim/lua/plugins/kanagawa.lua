return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = true,
			colors = {
				theme = {
					all = {
						diff = {
							add = "#2F4A3B",
							delete = "#5A2B31",
							change = "#2B3B54",
							text = "#4A5F80",
						},
					},
				},
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
