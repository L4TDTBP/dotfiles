return {
	"seblyng/roslyn.nvim",
	ft = { "cs", "razor" },
	opts = {
		config = {
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "fullSolution",
				},
			},
		},
	},
}
