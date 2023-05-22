local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(bufnr)
  print("hello, do you know that you're using lsp? if not sun of a gun!")
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()

  -- keybindings
  vim.keymap.set({ 'n', 'x' }, 'gF', function()
    vim.lsp.buf.format({
      async = true,
      timeout_ms = 10000,
    })
  end)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)

  -- lsp.format_mapping('gq', {
  --   servers = {
  --     ['black'] = { 'python' },
  --   }
  -- })
end)

lsp.skip_server_setup({ 'python-lsp-server' })
lsp.setup()
