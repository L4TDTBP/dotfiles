vim.opt_local.makeprg = "dotnet build -p:GenerateFullPaths=true -clp:NoSummary"
vim.opt_local.errorformat = "%f(%l\\,%c): %trror %m,%f(%l\\,%c): %tarning %m,%-G%.%#"

vim.keymap.set("n", "<leader>tm", "<cmd>make<cr>", { buffer = true, desc = "dotnet build" })
