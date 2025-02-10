vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- easy access to normal mode
vim.keymap.set('i', 'jj', '<Esc>')

-- clear search highlight
vim.keymap.set('n', '<leader>cs', ':let @/ = ""<CR>', { silent = true })

-- shortcuts for replacing in buffer
vim.keymap.set('n', '<leader>sb', ':%s/')
vim.keymap.set('n', '<leader>sl', ':s/')
vim.keymap.set('v', '<leader>sb', ":s/", { noremap = true })

-- escape terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- these keys are in an akward posisition on my keyboard
-- and I kept pressing them by accident
vim.keymap.set('n', '<PageUp>', "")
vim.keymap.set('n', '<PageDown>', "")
vim.keymap.set('i', '<PageUp>', "")
vim.keymap.set('i', '<PageDown>', "")

-- filepath completion
vim.keymap.set('i', '<c-f>', '<c-x><c-f>')

-- create file under cursor
vim.keymap.set('n', '<leader>gf', [[V:!xargs -I {} sh -c 'touch {}; echo {}'<CR>]], { silent = true })

-- surrounds the selected text in a math enviroment.
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "Surrounds the selected text in a math enviroment.",
    pattern = { "*.tex" },
    callback = function(ev)
        vim.keymap.set('v', '<leader>m', '"mc\\(<Esc>"mpa\\)',
            { noremap = true, buffer = ev.buf })
    end
})

-- open config.
vim.keymap.set('n', '<leader>se', function()
        vim.cmd(string.format([[
            tabnew
            tchdir %s
            edit %s/lua/config/init.lua
        ]],
            vim.fn.stdpath('config'),
            vim.fn.stdpath('config')
        ))
    end,
    {
        silent = true,
    }
)

require("config.keys.lsp")
require("config.keys.romanization")
