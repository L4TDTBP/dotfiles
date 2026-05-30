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
				automatic_enable = {
					{ exclude = { "stylua" } },
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
			})

			-- LSP using default config
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("yamlls")

			-- rosly_ls using custom config
			vim.lsp.enable("roslyn_ls")
			vim.lsp.config("roslyn_ls", {
				filetypes = { "razor", "cs" },
			})

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

			-- stylua is a formatter, not a language server.
			-- nvim-lspconfig ships an lsp/stylua.lua that mason-lspconfig
			-- auto-enables. Lua formatting is already handled by configm,
			-- so the LSP client is disabled here.
			vim.lsp.enable("stylua", false)

			-- PS LS using custom config
			vim.lsp.config("powershell_es", {
				bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
			})
			vim.lsp.enable("powershell_es")

			-- ltex_plus setup --
			---------------------
			-- read a wordlist file (one word per line) into a list, empty if missing
			local function read_words(path)
				local words = {}
				local f = io.open(path, "r")
				if f then
					for line in f:lines() do
						line = vim.trim(line)
						if line ~= "" then
							table.insert(words, line)
						end
					end
					f:close()
				end
				return words
			end

			local dict_dir = vim.fn.stdpath("config") .. "/ltex"

			-- Grammer and spell checking for academic writing
			vim.lsp.config("ltex_plus", {
				settings = {
					ltex = {
						-- Swiss German: expects "ss", not "ß"
						language = "de-CH",
						dictionary = {
							["de-CH"] = read_words(dict_dir .. "/de-CH.txt"),
							["en-US"] = read_words(dict_dir .. "/en-US.txt"),
						},
						additionalRules = {
							-- stricter style and grammer rules
							enablePickyRules = true,
							-- helpts detect false friends between de and en
							motherTongue = "de-CH",
						},
						-- show suggestions as info, not as loud errors
						diagnosticSeverity = "information",
					},
				},
			})
			vim.lsp.enable("ltex_plus")

			-- append the word unter the cursor to the German dictionary and reload
			vim.api.nvim_create_user_command("LtexAddWord", function()
				local word = vim.fn.expand("<cword>")
				if word == "" then
					return
				end

				vim.fn.mkdir(dict_dir, "p")
				local file = dict_dir .. "/de-CH.txt"
				if vim.tbl_contains(read_words(file), word) then
					vim.notify("Already in dictionary: " .. word)
					return
				end

				local f = io.open(file, "a")
				if f then
					f:write(word .. "\n")
					f:close()
				end
				vim.notify("Added to LTex dictionary: " .. word)

				-- push the updated wordlist to the running ltex client
				for _, client in ipairs(vim.lsp.get_clients({ name = "ltex_plus" })) do
					client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
						ltex = {
							dictionary = {
								["de-CH"] = read_words(dict_dir .. "/de-CH.txt"),
								["en-US"] = read_words(dict_dir .. "/en-US.txt"),
							},
						},
					})
					client:notify("workspace/didChangeConfiguration", { settings = client.settings })
				end
			end, {})

			-- Keymaps --
			-------------
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

					-- server-specific keymaps
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "ltex_plus" then
						vim.keymap.set(
							"n",
							"<leader>la",
							"<cmd>LtexAddWord<cr>",
							{ buffer = args.buf, desc = "LTeX: add word to dictionary" }
						)
					end
				end,
			})
		end,
	},
}
