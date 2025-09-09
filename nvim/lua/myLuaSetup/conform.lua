local conform = require("conform")
local util = require("conform.util")

-- Point the 'prettier' formatter to your binary + CLI options
conform.formatters.prettier = {
	command = "prettier",
	args = {
		"--stdin-filepath",
		"$FILENAME",
		"--print-width",
		"90",
		"--tab-width",
		"2",
		"--no-semi",
	},
	cwd = util.root_file({ ".prettierrc", ".prettierrc.json", "package.json", ".git" }),
	require_cwd = false,
}

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },

		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		json = { "biome" },
		css = { "biome" },
		scss = { "biome" },
		html = { "biome" },
		markdown = { "biome" },
		yaml = { "biome" },
	},

	format_on_save = {
		timeout_ms = 2000,
		-- Avoid LSP stepping in and changing indent rules
		lsp_fallback = false,
	},
})
