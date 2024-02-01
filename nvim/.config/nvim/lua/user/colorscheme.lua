-- -- tokio
-- local colorscheme = "tokyonight"
--
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   return
-- end

-- gruvbox colorscheme
-- setup must be called before loading the colorscheme
-- Default options:
-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = {
--     strings = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "",  -- can be "hard", "soft" or empty string
--   overrides = {},
--   dim_inactive = true,
--   transparent_mode = false,
--   palette_overrides = {
--     -- bright_green = "#990000",
--     dark0 = "#1e1e1e",
--     dark1 = "#252526",
--     dark2 = "#2d2d30",
--     dark3 = "#3e3e42",
--     dark4 = "#3e3e42",
--
--   }
-- })
--
-- vim.cmd("colorscheme gruvbox")

local c = require('vscode.colors').get_colors()
require('vscode').setup({
  -- Alternatively set style in setup
  -- style = 'light'

  -- Enable transparent background
  transparent = false,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = false,

  -- Override colors (see ~/.local/share/nvim/site/pack/packer/start/vscode.nvim/lua/vscode/colors.lua
  color_overrides = {
    -- vscLineNumber = '#aaaaaa',
  },

  -- Override highlight groups (see ./lua/vscode/theme.lua)
  group_overrides = {
    -- this supports the same val table as vim.api.nvim_set_hl
    -- use colors from this colorscheme by requiring vscode.colors!
    -- Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
  }
})
require('vscode').load()
