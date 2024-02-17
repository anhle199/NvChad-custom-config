--type conform.options
local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		sh = { "shfmt" },
		yaml = { "yamlfmt" },
		go = { "goimports", "gofumpt" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	-- format_on_save = {
	--   -- These options will be passed to conform.format()
	--   timeout_ms = 500,
	--   lsp_fallback = true,
	-- },

	format = {
		timeout_ms = 3000,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
	},
}

local prettier_file_types = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"css",
	"scss",
	"less",
	"html",
	"json",
	"jsonc",
	"markdown",
	"markdown.mdx",
	"graphql",
	"handlebars",
}
for ft in prettier_file_types do
	options["formatters_by_ft"][ft] = { "prettier" }
end

require("conform").setup(options)
