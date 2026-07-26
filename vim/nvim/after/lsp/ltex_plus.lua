return {
	settings = {
		ltex = {
			-- Swiss German: expects "ss", not "ß"
			language = "de-CH",
			additionalRules = {
				-- stricter style and grammar rules
				enablePickyRules = true,
				-- helps detect false friends between de and en
				motherTongue = "de-CH",
			},
			-- show suggestions as info, not as loud errors
			diagnosticSeverity = "information",
		},
	},
}
