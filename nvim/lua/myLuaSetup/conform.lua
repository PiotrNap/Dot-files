local conform = require("conform")
local util = require("conform.util")

-- Point the 'prettier' formatter to your binary + CLI options
-- conform.formatters.prettier = {
-- 	command = "prettier",
-- 	args = {
-- 		"--stdin-filepath",
-- 		"$FILENAME",
-- 		"--print-width",
-- 		"90",
-- 		"--tab-width",
-- 		"2",
-- 		"--no-semi",
-- 	},
-- 	cwd = util.root_file({ ".prettierrc", ".prettierrc.json", "package.json", ".git" }),
-- 	require_cwd = false,
-- }

local function has_biome_config(ctx)
  local dir = vim.fs.dirname(ctx.filename)
  local found = vim.fs.find({ "biome.json", "biome.jsonc" }, { path = dir, upward = true })
  return #found > 0
end

conform.setup({
     format_on_save = { lsp_fallback = true, timeout_ms = 5000 }, -- your 5s headroom
  formatters = {
    biome_project = {
      command = "biome",  -- assumes biome is on PATH (e.g., from node_modules/.bin via your shell)
      args = { "format", "--stdin-file-path", "$FILENAME" },
      stdin = true,
      condition = has_biome_config,
    },
    biome_global = {
      command = "biome",
      args = {
        "format",
        "--stdin-file-path", "$FILENAME",
        "--config-path", vim.fs.normalize("~/.config/biome/biome.json"),
      },
      stdin = true,
      condition = function(ctx) return not has_biome_config(ctx) end,
    },
  },
  formatters_by_ft = {
    javascript = { "biome_project", "biome_global" },
    typescript = { "biome_project", "biome_global" },
    javascriptreact = { "biome_project", "biome_global" },
    typescriptreact = { "biome_project", "biome_global" },
    json = { "biome_project", "biome_global" },
    jsonc = { "biome_project", "biome_global" },
    css = { "biome_project", "biome_global" },
    html = { "biome_project", "biome_global" },
    graphql = { "biome_project", "biome_global" },
    svelte = { "biome_project", "biome_global" },
    markdown = { "biome_project", "biome_global" },
    yaml = { "biome_project", "biome_global" },
  },

	-- formatters_by_ft = {
	-- 	lua = { "stylua" },
	-- 	python = { "ruff_fix", "isort", "black" },
	-- 	rust = { "rustfmt", lsp_format = "fallback" },

	-- 	javascript = { "biome" },
	-- 	javascriptreact = { "biome" },
	-- 	typescript = { "biome" },
	-- 	typescriptreact = { "biome" },
	-- 	json = { "biome" },
	-- 	css = { "biome" },
	-- 	scss = { "biome" },
	-- 	html = { "biome" },
	-- 	markdown = { "biome" },
	-- 	yaml = { "biome" },
	-- },

	-- format_on_save = {
	-- 	timeout_ms = 2000,
	-- 	-- Avoid LSP stepping in and changing indent rules
	-- 	lsp_fallback = false,
	-- },
})
