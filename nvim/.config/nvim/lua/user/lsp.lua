local status_ok, lsp_zero = pcall(require, "lsp-zero")
if not status_ok then
  vim.notify("lsp-zero don't work")
  return
end

lsp_zero.preset('recommended')

lsp_zero.on_attach(function(bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()

  -- keybindings
  vim.keymap.set({ 'n', 'x' }, 'gF', function()
    vim.lsp.buf.format({
      async = true,
      timeout_ms = 10000,
    })
  end)
  -- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)

  -- lsp.format_mapping('gq', {
  --   servers = {
  --     ['black'] = { 'python' },
  --   }
  -- })
end)

local lspconfig = require('lspconfig')
-- (Optional) Configure lua language server for neovim
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 't' },
      },
      -- completion = {
      --   callSnippet = "Replace"
      -- }
    }
  }
}
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lspconfig.clangd.setup({ capabilities = capabilities })

-- lsp.skip_server_setup({ 'python-lsp-server' })
lsp_zero.setup()
