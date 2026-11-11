return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 300,
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			triggers = {
				{ "<auto>", mode = "nxso" },
				{ "s", mode = { "n", "v" } },
				{ "g", mode = { "n", "v" } },
			},
		})

		-- named groups, for a better overview
		wk.add({
			{ "<leader>f", group = "find" },
			{ "<leader>d", group = "Debugger" },
			{ "<leader>r", group = "refactor" },
			{ "<leader>g", group = "go to" },
			{ "<leader>t", group = "tools" },
			{ "<leader>c", group = "code action" },
			{ "<leader>ca", group = "all code" },
			{ "g", group = "go to" },
			{ "s", group = "split" },
			{ "sm", group = "move split" },
			{ "]", group = "next" },
			{ "[", group = "previous" },
		})
	end,
}
