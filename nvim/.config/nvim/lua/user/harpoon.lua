-- how to use it

-- <leader>ha: add current file to harpoon
-- <leader>b: show harpoon marks in telescope
---- C^a: add mark
---- C^d: delete mark
---- C^c: close telescope

local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  vim.notify("harpoon don't work")
  return
end

harpoon.setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = {},

    -- set marks specific to each git branch inside git repository
    mark_branch = false,

    -- enable tabline with harpoon marks
    tabline = false,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
  },
  -- projects = {
  --   ["~/code/"] = {
  --     term = {
  --       cmds = {
  --         "make",
  --         "make test",
  --       }
  --     }
  --   }
  -- }
})

-- instead of ctrl use alt

-- not working -- calling list (nil value)
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-l>", function() harpoon:list():select(4) end)
