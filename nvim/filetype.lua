vim.filetype.add({
	extension = {
		astro = "astro",
		prisma = "graphql"
	},
	filename = {
		['.prettierrc'] = "json",
		['.eslintrc'] = "json"
	},
	pattern = {
		['.env.*'] = "sh"
	}
})
