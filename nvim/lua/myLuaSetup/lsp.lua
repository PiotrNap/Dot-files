local lsp_config = require('lspconfig')
local on_attach = require('myLuaSetup.on_attach')
local set_lsp_config = require('myLuaSetup.utils')
local util = require('lspconfig.util')

USER = vim.fn.expand('$USER')

lsp_config.tsserver.setup {
    cmd = { "/home/bob/.nvm/versions/node/v18.16.0/bin/tsserver", "--stdio" },

  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.server_capabilities.document_formatting = false
    set_lsp_config(client)
  end
}

lsp_config.eslint.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.vimls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.cssls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.html.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.jsonls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.jsonls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})

lsp_config.hls.setup({
    on_attach = function(client)
        vim.api.nvim_buf_set_keymap(0, "n"," le", "<cmd>lua vim.diagnostic.open_float()<cr>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n"," ne", "<cmd>lua vim.diagnostic.goto_next()<cr>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n"," pe", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {noremap = true})
        on_attach(client)
    end,
    settings = {
        haskell = {
            formattingProvider = 'stylish-haskell'
        }
    }
})
