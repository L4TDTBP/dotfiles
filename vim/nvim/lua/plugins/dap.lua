return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"igorlfs/nvim-dap-view",
			{
				"L4TDTBP/dap-powershell.nvim",
				-- branch = "feature/terminal-insert-mode",
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "toggle breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "continue",
			},
			{
				"<leader>du",
				function()
					require("dap-view").toggle()
				end,
				desc = "debug UI",
			},
			{
				"<leader>dq",
				function()
					require("dap").terminate()
				end,
				desc = "terminate",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				mode = { "n", "v" },
				desc = "hover variable",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "toggle repl",
			},
			{
				"<Down>",
				function()
					require("dap").step_over()
				end,
				desc = "step over",
			},
			{
				"<Right>",
				function()
					require("dap").step_into()
				end,
				desc = "step into",
			},
			{
				"<Left>",
				function()
					require("dap").step_out()
				end,
				desc = "step out",
			},
			{
				"<Up>",
				function()
					require("dap").restart_frame()
				end,
				desc = "restart frame",
			},
		},
		config = function()
			require("dap").set_log_level("INFO") -- use "TRACE" for debugging
			require("dap").defaults.fallback.external_terminal = {
				command = "kitty",
				args = { "--hold", "--" },
			}
			require("dap-powershell").setup()
			require("dap-view").setup({
				winbar = {
					sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
				},
			})
		end,
	},
}
