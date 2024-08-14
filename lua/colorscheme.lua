local colorscheme = "hardhacker"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end

vim.api.nvim_set_hl(0, "Visual", { bg = "#4a4263", fg = "NONE", ctermbg = 242 })

