return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_view_skim_activate = 1

		-- Don't auto-open the quickfix list on warnings
		vim.g.vimtex_quickfix_mode = 0

		-- Conceal math commands, accents and similar for readability
		vim.g.vimtex_syntax_conceal = {
			accents = 1,
			ligatures = 1,
			cites = 1,
			fancy = 1,
			spacing = 0,
			greek = 1,
			math_bounds = 1,
			math_delimiters = 1,
			math_fracs = 1,
			math_super_sub = 1,
			math_symbols = 1,
			sections = 0,
			styles = 1,
		}

		-- Table of contents panel layout
		vim.g.vimtex_toc_config = {
			split_pos = "vert",
			split_width = 40,
			show_help = 0,
		}

		-- Keep auxiliary build files out of the project root
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "build",
			out_dir = "build",
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
	end,
}
