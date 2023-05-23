-- local buf_map = require('utils').buf_map
-- local buf_option = require('myLuaSetup.utils').buf_option

local function on_attach(client)
  -- buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {
    noremap = true,
    silent = true
  }
end

return on_attach
