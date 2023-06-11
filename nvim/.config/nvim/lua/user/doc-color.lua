local status_ok, doc_color = pcall(require, "document-color")
if not status_ok then
  return
end

doc_color.setup {
  -- Default options
  mode = "background", -- "background" | "foreground" | "single"
}
