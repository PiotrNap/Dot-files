local lsp_config = require('lspconfig')
local on_attach = require('myLuaSetup.on_attach')
local set_lsp_config = require('myLuaSetup.utils')

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

lsp_config.tsserver.setup {
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    set_lsp_config(client)
  end
}

-- lsp_config.efm.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--     set_lsp_config(client)
--   end,
--   root_dir = function()
--     if not eslint_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     languages = {
--       javascript = {eslint},
--       javascriptreact = {eslint},
--       ["javascript.jsx"] = {eslint},
--       typescript = {eslint},
--       ["typescript.tsx"] = {eslint},
--       typescriptreact = {eslint}
--     }
--   },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }

lsp_config.vimls.setup({
  on_attach = on_attach
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
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.vuels.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})

