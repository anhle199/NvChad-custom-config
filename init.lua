local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

opt.mouse = ""
opt.linebreak = true
opt.confirm = true
g.maplocalleader = " "

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})