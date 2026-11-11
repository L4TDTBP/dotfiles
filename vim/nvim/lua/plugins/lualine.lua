return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				theme = "kanagawa",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
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
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							return string.format("􀥎  %d lsps", #clients)
						end,
					},
				},
				lualine_y = {
					"filetype",
					icon_only = true,
				},
				lualine_z = {
					{
						function()
							return vim.fn.line(".") .. "/" .. vim.fn.line("$")
						end,
					},
				},
			},
		})
	end,
}
