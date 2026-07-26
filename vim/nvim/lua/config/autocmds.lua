-- React to QuickFixCmdPost event when make -> put build errors and warning
-- into quickfix window

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "make",
	callback = function()
		vim.cmd.cwindow() -- open the quickfix window only if there are results
	end,
})

-- React to User event when ClaudeCodeSendComplete -> use aerospace to focus
-- claude-code window

vim.api.nvim_create_autocmd("User", {
	pattern = "ClaudeCodeSendComplete",
	callback = function()
		vim.system(
			{ "aerospace", "list-windows", "--all", "--format", "%{window-id}|%{window-title}" },
			{ text = true },
			function(res)
				if res.code ~= 0 or not res.stdout then
					return
				end
				for line in res.stdout:gmatch("[^\n]+") do
					local id, title = line:match("^(%d+)|(.*)$")
					if title and title:find("claude-code", 1, true) then
						vim.system({ "aerospace", "focus", "--window-id", id })
						return
					end
				end
			end
		)
	end,
})
