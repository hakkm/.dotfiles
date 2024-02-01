local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
-- require("lspconfig").clangd.setup({ capabilities = capabilities })

for key, value in pairs(myObject) do
  if type(value) == "function" then
    print("Method:", key)
  else
    print("Attribute:", key, "Value:", value)
  end
end
