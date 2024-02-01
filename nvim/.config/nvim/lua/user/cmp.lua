local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<S-CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-CR>"] = function(fallback)
      cmp.abort()
      fallback()
    end,
  }),
  -- mapping = {
  --   -- ["<C-k>"] = cmp.mapping.select_prev_item(),
  --   ["<C-j>"] = cmp.mapping.select_next_item(),
  --   ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
  --   ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
  --   -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  --   ["<C-e>"] = cmp.mapping {
  --     i = cmp.mapping.abort(),
  --     c = cmp.mapping.close(),
  --   },
  --   ["<C-l>"] = cmp.mapping {
  --     i = cmp.mapping.abort(),
  --     c = cmp.mapping.close(),
  --   },
  --   -- Accept currently selected item. If none selected, `select` first item.
  --   -- Set `select` to `false` to only confirm explicitly selected items.
  --   ["<CR>"] = cmp.mapping.confirm { select = true },
  --   -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --   --   if cmp.visible() and has_words_before() then
  --   --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --   --   else
  --   --     fallback()
  --   --   end
  --   -- end),
  --   ["<S-Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_prev_item()
  --     elseif luasnip.jumpable(-1) then
  --       luasnip.jump(-1)
  --     else
  --       fallback()
  --     end
  --   end, {
  --     "i",
  --     "s",
  --   }),
  --   ["<C-k>"] = cmp.mapping({
  --     n = cmp.mapping.select_prev_item(),
  --     -- i = function()
  --     --   if cmp.visible() then
  --     --     cmp.abort()
  --     --   else
  --     --     cmp.complete()
  --     --   end
  --     -- end,
  --     i = function(_)
  --       if cmp.visible() then
  --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  --       elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
  --         vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
  --       else
  --         vim.api.nvim_feedkeys(t('<Tab>'), 'n', true) -- fallback()
  --       end
  --     end,
  --
  --     c = function()
  --       if cmp.visible() then
  --         cmp.close()
  --       else
  --         cmp.complete()
  --       end
  --     end,
  --   }),
  -- },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[ASYNC_Path]",
        copilot = "[Copilot]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- for sql
    { name = "vim-dadbod-completion" },
    { name = "nvim_lsp" },
    { name = "copilot" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "async_path" },
    { name = "nvim_lua" },
    { name = 'pandoc_references' }, -- md
    { name = "plugins" },
    -- { name = "fonts" },
    -- { name = "color_names" },
    { name = "cmp-vimtex" },
    -- { name = "orgmode" },
    -- { name = "nvim-html-css" },
    -- { name = "cmp-clippy" },
    -- { name = "zsh" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  completion = {
    -- autocomplete = false,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      --require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

-- prioritizing vim-dadbod-completion for sql files
vim.cmd [[
  augroup CmpRestriction
    autocmd!
    autocmd FileType sql lua require'cmp'.setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
    autocmd FileType html lua require'cmp'.setup.buffer { sources = { { name = 'nvim-html-css' } } }
    autocmd FileType css lua require'cmp'.setup.buffer { sources = { { name = 'nvim-html-css' } } }
  augroup END
]]

-- autocmd FileType markdown lua require'cmp'.setup.buffer { sources = {{ name = 'nvim-html-css' },{ name = 'pandoc_references' },{ name = "async_path" },{ name = "copilot" },{ name = "luasnip" }, { name = "buffer" } } }
