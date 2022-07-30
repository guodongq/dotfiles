local status, surround = pcall(require, "surround")
if not status then
  return
end

surround.setup({
  mappings_style = "surround",
})
