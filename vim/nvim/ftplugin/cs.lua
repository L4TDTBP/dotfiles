vim.opt_local.makeprg = "dotnet build --no-incremental -tl:off -clp:NoSummary"
vim.opt_local.errorformat = table.concat({
	"%f(%l\\,%c): %trror %m",
	"%f(%l\\,%c): %tarning %m",
	"%f : %trror %m",
	"%f : %tarning %m",
	"%-G%.%#",
}, ",")

vim.keymap.set("n", "<leader>tm", "<cmd>make!<cr>", { buffer = true, desc = "dotnet build" })
