local map = vim.keymap.set

vim.g.mapleader = ','
vim.g.maplocalleader = ','

map('n', '<leader>cs', ':let @/ = ""<CR>', { silent = true }) -- clear search hi

-- shortcuts for replacing in buffer
map('n', '<leader>sb', ':%s/')
map('n', '<leader>sl', ':s/')
map('v', '<leader>sv', ":s/", { noremap = true })

-- better wrapping movement
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

map('n', '<leader>se', function()
    vim.cmd(string.format([[
    edit %s/lua/config/init.lua
    Neotree right dir=%s
    ]],
    vim.fn.stdpath('config'),
    vim.fn.stdpath('config')
    ))
end,
{ silent = true }
)

map('t', '<Esc>', '<C-\\><C-n>') -- escape terminal mode

map('n', '<PageUp>', "")
map('n', '<PageDown>', "")
map('i', '<PageUp>', "")
map('i', '<PageDown>', "")

map('i', '<c-f>', '<c-x><c-f>')

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*.tex" },
    callback = function(ev)
        map('v', '<leader>m', '"mc\\(<Esc>"mpa\\)',
        { noremap = true, buffer = ev.buf })
    end
})

require("config.keys.lsp")
require("config.keys.romanization")
