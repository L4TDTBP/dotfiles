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
				-- stylua is a formatter, not a language server. nvim-lspconfig still ships
				-- an lsp/stylua.lua that runs `stylua --lsp`, which automatic_enabled would
				-- start and which my stylua build rejects -> so I exclude it
				automatic_enable = {
					exclude = { "stylua" },
				},
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"powershell_es",
				},
				-- automatic_enable defaults to true and enables every mason-installed
				-- server. Per-server overrides live in after/lsp/<name>.lua.
			})

			-- Not handled by automatic_enable (third-party registry / not in
			-- ensure_installed), so enable explicitly. Config lives in after/lsp/.
			vim.lsp.enable("ltex_plus")

			-- Jump to the highest severity currently present; descend to the next
			-- tier only once the current one is fully resolved.
			local function jump_diagnostic(forward)
				local severities = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.INFO,
					vim.diagnostic.severity.HINT,
				}

				for _, severity in ipairs(severities) do
					if #vim.diagnostic.get(0, { severity = severity }) > 0 then
						vim.diagnostic.jump({
							count = forward and 1 or -1,
							severity = severity,
							float = true, -- optional: show the float after jumping
						})
						return
					end
				end
			end

			-- Keymaps
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
					end, { buffer = args.buf, desc = "organize imports" })

					-- diagnostics
					vim.keymap.set(
						"n",
						"<leader>dd",
						vim.diagnostic.open_float,
						{ buffer = args.buf, desc = "show diagnostic" }
					)
					vim.keymap.set("n", "gnd", function()
						jump_diagnostic(true)
					end, { buffer = args.buf, desc = "go to next diagnostic (severity priority)" })
					vim.keymap.set("n", "gpd", function()
						jump_diagnostic(false)
					end, { buffer = args.buf, desc = "go to previous diagnostic (severity priority)" })
				end,
			})
		end,
	},
}
