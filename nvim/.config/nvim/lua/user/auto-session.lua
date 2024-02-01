local status_ok, autosession = pcall(require, "auto-session")
if not status_ok then
  vim.notify("Missing auto-session dependency", vim.log.levels.ERROR)
  return
end

autosession.setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/docs", "~/dows", "/" },

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default
    pre_cwd_changed_hook = nil,      -- already the defaul
  },
  session_lens = {
    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
}

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
