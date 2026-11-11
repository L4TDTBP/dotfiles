return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter", -- neovim autocmd-event (entering insert mode)
	dependencies = {
		-- snippet engine used by blink for expansion
		"L3MON4D3/LuaSnip",
		-- bridge plus source for vimtex citation and reference completion
		{ "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
		"micangl/cmp-vimtex",
	},
	opts = {
		keymap = { preset = "enter" },
		completion = {
			-- nothing is selected by default, so <CR> inserts a newline
			-- unless an item was explicitly selected
			list = { selection = { preselect = false, auto_insert = true } },
			documentation = { auto_show = false },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		-- use LuaSnip as the snippet engine
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- prose-heavy writing: drop the buffer source for tex and md so
			-- ordinary German words don't clutter the completion menu
			per_filetype = {
				tex = { "lsp", "path", "snippets", "vimtex" },
				md = { "lsp", "path", "snippets" },
			},
			providers = {
				-- name must match the nvim-cmp source name
				vimtex = {
					name = "vimtex",
					module = "blink.compat.source",
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
