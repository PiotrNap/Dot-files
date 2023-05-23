local function set_lsp_config(client)
  vim.cmd [[setlocal signcolumn=yes]]
  -- vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]]
  -- vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next()<CR>]]
  -- vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev()<CR>]]

  vim.cmd [[setlocal omnifunc=v:lua.vim.lsp.omnifunc]]

  if client.resolved_capabilities.hover then
    vim.cmd [[nnoremap <buffer><silent> K :lua vim.lsp.buf.hover()<CR>]]
  end

  -- if client.resolved_capabilities.goto_definition then
    -- vim.cmd [[nnoremap <buffer><silent> [d :lua require"lsp_utils".definition_sync()<CR>]]
    -- vim.cmd [[nnoremap <buffer><silent> [<C-d> :lua require"lsp_utils".definition_sync()<CR>]]
    -- vim.cmd [[nnoremap <buffer><silent> <C-w><C-d> :split <bar> lua require"lsp_utils".definition_sync('split')<CR>]]
    -- vim.cmd [[nnoremap <buffer><silent> <C-c><C-p> :lua require"lsp_utils".peek_definition()<CR>]]
  -- end

  if client.resolved_capabilities.type_definition then
    vim.cmd [[nnoremap <buffer><silent> [t :lua vim.lsp.buf.type_definition()<CR>]]
  end

  if client.resolved_capabilities.find_references then
    vim.cmd [[command! -buffer References lua vim.lsp.buf.references()]]
  end

  if client.resolved_capabilities.rename then
    vim.cmd [[nnoremap <buffer><silent> gR :lua vim.lsp.buf.rename()<CR>]]
  end

  if client.resolved_capabilities.code_action then
    vim.cmd [[nnoremap <buffer><silent> <M-CR> :lua vim.lsp.buf.code_action()<CR>]]
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[command! -buffer Fmt lua vim.lsp.buf.formatting_sync(nil, 1000)]]
    vim.cmd [[augroup LspFormatOnSave]]
    vim.cmd [[  au!]]
    vim.cmd [[  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 500)]]
    vim.cmd [[augroup END]]
  end

  if client.resolved_capabilities.signature_help then
    vim.cmd [[inoremap <buffer><silent> <C-x><C-p> <C-o>:lua vim.lsp.buf.signature_help()<CR>]]
  end

  if client.name == "tsserver" then
    vim.cmd [[nnoremap <silent> <S-M-o> :lua require'tsserver_utils'.organize_imports()<CR>]]

    -- vim.cmd [[augroup LspImportAfterCompletion]]
    -- vim.cmd [[  au!]]
    -- vim.cmd [[  autocmd CompleteDone <buffer> lua require"lsp_utils".import_after_completion()]]
    -- vim.cmd [[augroup END]]

    -- _G.rename_hook = require "tsserver_utils".rename
  end
end

return set_lsp_config
