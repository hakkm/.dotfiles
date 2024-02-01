-- copilot.vim
-- vim.g.copilot_filetypes = {
--   lua = true
-- }

-- vim.api.nvim_set_keymap("i", "<C-I>", 'copilot#Accept("<Tab>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-L>', '<C-R>=copilot#Accept("")<CR>', { desc = "Use copilot", remap = false })
-- fix tab add new line instead of indent in insert mode
vim.g.copilot_filetypes = {
  ["*"] = false,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = true,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
  ["markdown"] = true,
}
