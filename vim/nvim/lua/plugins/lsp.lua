return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"powershell_es",
				},
			})

			-- LSP using default config
			vim.lsp.enable("roslyn_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("yamlls")

			-- Lua_LS using custom config
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")

			-- PS LS using custom config
			vim.lsp.config("powershell_es", {
				bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
			})
			vim.lsp.enable("powershell_es")

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					-- navigation
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "go to definition" })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "find references" })
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ buffer = args.buf, desc = "go to implementation" }
					)
					vim.keymap.set(
						"n",
						"gt",
						vim.lsp.buf.type_definition,
						{ buffer = args.buf, desc = "go to type definition" }
					)

					-- information
					vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = args.buf, desc = "hover documentation" })
					vim.keymap.set(
						"n",
						"gs",
						vim.lsp.buf.signature_help,
						{ buffer = args.buf, desc = "signature help" }
					)

					-- actions
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "rename symbol" })
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = args.buf, desc = "code action" }
					)
					vim.keymap.set("n", "<leader>oi", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.removeUnusedImports" },
								diagnostics = {},
							},
						})
					end, { buffer = args.buf, desc = "organize imports " })

					-- diagnostics
					vim.keymap.set(
						"n",
						"<leader>dd",
						vim.diagnostic.open_float,
						{ buffer = args.buf, desc = "show diagnostic" }
					)
					vim.keymap.set("n", "gnd", function()
						vim.diagnostic.jump({ count = 1 })
					end, { buffer = args.buf, desc = "go to next diagnostic" })
					vim.keymap.set("n", "gpd", function()
						vim.diagnostic.jump({ count = -1 })
					end, { buffer = args.buf, desc = "go to previous diagnostic" })
				end,
			})
		end,
	},
}
