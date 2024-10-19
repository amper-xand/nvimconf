vim.opt.splitright = true

vim.keymap.set('n', '<F5>', ':setlocal spell!<CR>', { silent = true })
vim.opt.spelllang = "en_us,es"

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
-- vim.opt.pumblend = 10

vim.cmd([[highlight Normal ctermbg=none]])
vim.cmd([[highlight NonText ctermbg=none]])

vim.g.netrw_banner    = 0
vim.g.netrw_liststyle = 3

vim.opt.updatetime    = 100

-- vim.cmd [[autocmd WinNew * wincmd L]]
