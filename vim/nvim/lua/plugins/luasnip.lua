return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	build = "make install_jsregexp",
	dependencies = {
		-- community snippet collection in VSCode format
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")
		ls.setup({
			-- expand autosnippets while typing (fast math input)
			enable_autosnippets = true,
			-- key to jump back into the last visual selection
			store_selection_keys = "<Tab>",
		})

		-- load friendly-snippets (VSCode-format collection)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- load my own Lua snippets from ~/.config/nvim/snippets
		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})

		-- cycle through choice nodes (e.g. the language in code snippets)
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { desc = "LuaSnip: next choice" })
	end,
}
