-- React to QuickFixCmdPost event when make -> put build errors and warning
-- into quickfix window

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "make",
	callback = function()
		vim.cmd.cwindow() -- open the quickfix window only if there are results
	end,
})
