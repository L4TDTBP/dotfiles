return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			move = {
				set_jumps = true,
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "gnm", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
		end, { desc = "next method start" })
		vim.keymap.set({ "n", "x", "o" }, "gnc", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
		end, { desc = "next class start" })
		vim.keymap.set({ "n", "x", "o" }, "gpm", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
		end, { desc = "previous method start" })
		vim.keymap.set({ "n", "x", "o" }, "gpc", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
		end, { desc = "previous class start" })
	end,
}
