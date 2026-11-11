return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", "folke/snacks.nvim" },
	ft = { "cs", "razor", "csproj", "sln", "slnx" },
	keys = {
		{ "<leader>dd", "<cmd>Dotnet debug profile default<cr>", desc = "debug default project with profile" },
		{ "<leader>dD", "<cmd>Dotnet debug profile<cr>", desc = "debug pick project and profile" },
		{ "<leader>da", "<cmd>Dotnet debug attach<cr>", desc = "debug attach" },
	},
	config = function()
		require("easy-dotnet").setup({
			picker = "snacks",
			-- Run (:Dotnet run) in a separate kitty window instead of the managed terminal panel
			external_terminal = { command = "kitty", args = { "--hold", "--" } },
			lsp = {
				enabled = true,
				config = {
					settings = {
						["csharp|background_analysis"] = {
							dotnet_analyzer_diagnostics_scope = "openFiles",
							dotnet_compiler_diagnostics_scope = "fullSolution",
						},
					},
				},
			},
			debugger = {
				engine = "sharpdbg", -- fallback: "netcoredbg"
				console = "externalTerminal", -- debuggee runs in a kitty window
				auto_register_dap = true,
			},
		})
	end,
}
