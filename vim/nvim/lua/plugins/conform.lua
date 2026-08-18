return {
	"stevearc/conform.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("conform").setup({
			-- formatter pro dateityp
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				-- cs: intentionally not listed, Roslyn LSP formats via fallback
				-- using the .editorconfig rules
			},
			-- format on save
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})

		-- manual format keymap
		vim.keymap.set("n", "<leader>cf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "format buffer" })
	end,
}
