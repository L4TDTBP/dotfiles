return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				theme = "kanagawa",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1) -- Just first letter (N, I, V, etc.)
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						function()
							local name = vim.fn.expand("%")
							if name:match("^oil://") then
								return name:gsub("^oil://", "")
							end
							return name
						end,
					},
				},
				lualine_x = {
					{
						"filetype",
						icon_only = true,
					},
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return table.concat(names, ", ")
						end,
					},
				},
				lualine_y = {},
				lualine_z = {
					{
						function()
							return vim.fn.line(".") .. "/" .. vim.fn.line("$")
						end,
					},
				},
			},
		})

		-- Hide lualine in terminal buffers (like pses)
		vim.api.nvim_create_autocmd("TermOpen", {
			callback = function()
				vim.opt_local.laststatus = 0
			end,
		})
	end,
}
