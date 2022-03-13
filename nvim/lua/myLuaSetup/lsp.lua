local lsp_config = require('lspconfig')
local on_attach = require('myLuaSetup.on_attach')
local set_lsp_config = require('myLuaSetup.utils')
local util = require('lspconfig.util')

vim.lsp.set_log_level('debug')

USER = vim.fn.expand('$USER')

-- local sumneko_root_path = '/home/' .. USER .. '/.config/nvim/lua-language-server'
-- local sumneko_binary = '/home/' .. USER .. '/.config/nvim/lua-language-server/bin/Linux/lua-language-server'

-- local function eslint_config_exists()
--   local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

--   if not vim.tbl_isempty(eslintrc) then
--     return true
--   end

--   if vim.fn.filereadable("package.json") then
--     if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
--       return true
--     end
--   end

--   return false
-- end

-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   formatStdin = true
-- }

lsp_config.tsserver.setup {
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    set_lsp_config(client)
  end
}

lsp_config.vimls.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.cssls.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.html.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.jsonls.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.hls.setup({
    on_attach = function(client)
        vim.api.nvim_buf_set_keymap(0, "n"," le", "<cmd>lua vim.diagnostic.open_float()<cr>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n"," ne", "<cmd>lua vim.diagnostic.goto_next()<cr>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n"," pe", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {noremap = true})

        settings = {
            haskell = {
                formattingProvider = 'stylish-haskell'
            }
        }
        on_attach(client)
    end
})
