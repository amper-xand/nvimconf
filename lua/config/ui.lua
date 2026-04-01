local on_yank          = function() pcall(vim.highlight.on_yank) end
vim.api.nvim_create_autocmd("TextYankPost", { callback = on_yank })

vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true,  reverse = true })
vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true,  reverse = true })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, reverse = true })

vim.opt.bg = "dark"
vim.cmd.colorscheme('catppuccin')
