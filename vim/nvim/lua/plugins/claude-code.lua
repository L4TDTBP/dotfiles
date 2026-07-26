return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal = {
			provider = "external",
			provider_opts = {
				external_terminal_cmd = "kitty --title claude-code %s", -- %s becomes the claude command
			},
		},
	},
	config = true,
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
