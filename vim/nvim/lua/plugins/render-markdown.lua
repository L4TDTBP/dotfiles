return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		heading = {
			enabled = true,
			sign = false,
			icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
		},
		code = {
			enabled = true,
			sign = false,
			style = "full",
		},
		dash = {
			enabled = true,
		},
		bullet = {
			enabled = true,
		},
		checkbox = {
			enabled = true,
		},
		pipe_table = {
			enabled = true,
			style = "full",
		},
	},
}
