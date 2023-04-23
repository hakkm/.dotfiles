local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
  vim.notify("code_runner not found")
end

code_runner.setup {
  -- choose default mode (valid term, tab, float, toggle, buf)
  mode = 'term',
  -- Focus on runner window(only works on toggle, term and tab mode)
  focus = true,
  -- startinsert (see ':h inserting-ex')
  startinsert = true,
  term = {
    --  Position to open the terminal, this option is ignored if mode is tab
    position = "bot",
    -- window size, this option is ignored if tab is true
    size = 8,
  },
  float = {
    -- Key that close the code_runner floating window
    close_key = '<esc>',
    -- Window border (see ':h nvim_open_win')
    border = "none",

    -- Num from `0 - 1` for measurements
    height = 0.8,
    width = 0.8,
    x = 0.5,
    y = 0.5,

    -- Highlight group for floating window/border (see ':h winhl')
    border_hl = "FloatBorder",
    float_hl = "Normal",

    -- Transparency (see ':h winblend')
    blend = 0,
  },
  -- filetype_path = "/home/khabir/.config/nvim/lua/user/code-runner/settings.json", -- No default path defined
  -- filetype_path= vim.fn.expand('~/.config/nvim/lua/user/code-runner/settings.json'),
  filetype = {
    javascript = "node",
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    c = 'cd $dir ; mkdir -p bin && gcc $fileName -o ./bin/$fileNameWithoutExt -lm && echo  && ./bin/$fileNameWithoutExt && echo " "',
    cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    python = "echo && python3 -u",
    sh = "bash",
    rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
  },
  project_path = "", -- No default path defined
  project = {},
}

-- keymaps -- 
local opts = { noremap = true, silent = false }
local keymap = vim.keymap.set
-- keymap('n', '<leader>r', ':RunCode<CR>', opts )
-- keymap('n', '<leader>rft', ':RunFile tab<CR>', opts)
-- keymap('n', '<leader>rc', ':RunClose<CR>', opts)
keymap('n', '<leader>r', ':w <CR>:RunFile toggleterm<CR>', opts)
keymap('n', '<leader>u', ":w <CR>:!gcc -E $fileName > proc_main.c<CR>", opts)
-- keymap('n', '<leader>rp', ':RunProject<CR>', opts)
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', opts)
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', opts)
