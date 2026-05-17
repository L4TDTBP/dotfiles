-- Buffer-local settings for LaTeX writing

vim.opt_local.spell = false
-- de_ch expects "ss" insead of "ß"
vim.opt_local.spelllang = { "de_ch", "en_us" }

-- Soft-wrap prose without inserting hard line breaks
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 2

-- Move by visual lines, not logical lines, in wrapped text
vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true })
vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true })

-- Which-Key
local ok, wk = pcall(require, "which-key")
if ok then
	wk.add({ { "<localleader>l", group = "LaTeX", buffer = 0 } })
end
