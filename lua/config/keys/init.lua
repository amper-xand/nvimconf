local map = vim.keymap.set

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- clear search highlight
map('n', '<leader>cs', ':let @/ = ""<CR>', { silent = true })

-- shortcuts for replacing in buffer
map('n', '<leader>sb', ':%s/')
map('n', '<leader>sl', ':s/')
map('v', '<leader>sv', ":s/", { noremap = true })

-- go to neovim confifuration in a new tab
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

-- escape terminal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- these keys are in an akward posisition on my keyboard
-- and I kept pressing them by accident
map('n', '<PageUp>', "")
map('n', '<PageDown>', "")
map('i', '<PageUp>', "")
map('i', '<PageDown>', "")

-- filepath completion
map('i', '<c-f>', '<c-x><c-f>')

-- surrounds the selected text in a math enviroment.
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "Surrounds the selected text in a math enviroment.",
    pattern = { "*.tex" },
    callback = function(ev)
        map('v', '<leader>m', '"mc\\(<Esc>"mpa\\)',
            { noremap = true, buffer = ev.buf })
    end
})

require("config.keys.lsp")
require("config.keys.romanization")
