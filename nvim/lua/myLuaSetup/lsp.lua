local lsp_config = require("lspconfig")
local on_attach = require("myLuaSetup.on_attach")
local util = require("lspconfig.util")

local set_lsp_config = require("myLuaSetup.utils")

local servers = {
  'solidity_ls', 'gopls', 'svelte', 'pyright', 'vimls', 'biome',
  'cssls', 'html', 'jsonls', 'yamlls', 'markdown_oxide', 'ts_ls'
}

for _, name in ipairs(servers) do
	local opts = {
		on_attach = function(client, bufnr)
			-- fully disable LSP-driven formatting from this server
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			if on_attach then
				on_attach(client, bufnr)
			end
		end,
	}

	-- extra per-server switches to kill built-in formatters
	if name == "ts_ls" then
		opts.settings = {
			javascript = { format = { enable = false } },
			typescript = { format = { enable = false } },
		}
	elseif name == "jsonls" then
		opts.settings = { json = { format = { enable = false } } }
	elseif name == "html" then
		opts.init_options = { provideFormatter = false }
	elseif name == "cssls" then
		opts.settings = { css = { validate = true }, scss = { validate = true }, less = { validate = true } }
		-- cssls doesn’t expose a clean switch; capability disable above is enough
    elseif name == 'biome' then
        opts.root_dir = util.root_pattern("biome.json", "biome.jsonc")
        opts.single_file_support = false
        -- optional: capabilities = require("cmp_nvim_lsp").default_capabilities(),
	end

	if lsp_config[name] then
		lsp_config[name].setup(opts)
	else
		vim.notify("No LSP config found for: " .. name, vim.log.levels.WARN)
	end
end
