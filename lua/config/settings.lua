vim.opt.splitright = true

vim.keymap.set('n', '<F5>', ':setlocal spell!<CR>', { silent = true })
vim.opt.spelllang = "en_us,es,ru"

vim.cmd "set number relativenumber" -- vim.opt.relativenumber = true
vim.opt.cursorline    = true

vim.opt.breakindent   = true

vim.opt.scrolloff     = 20
vim.opt.sidescrolloff = 20

vim.opt.expandtab     = true
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4

vim.opt.virtualedit   = 'all'

vim.opt.foldmethod    = 'indent'
vim.opt.foldlevel     = 99

vim.opt.pumheight     = 10
vim.opt.pumwidth      = 12

vim.g.netrw_banner    = 0
vim.g.netrw_liststyle = 3

vim.opt.updatetime    = 100

local on_yank = function() pcall(vim.highlight.on_yank) end
vim.api.nvim_create_autocmd("TextYankPost", { callback = on_yank })

-- just in case I switch to a theme that does not support this
vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true, bg = "BLACK" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true, bg = "BLACK" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, bg = "BLACK" })
