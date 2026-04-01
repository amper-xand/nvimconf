vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- open file explorer
vim.keymap.set('n', '<leader>e', ':Explore<Esc>', { silent = true })

-- escape terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- clear search highlight
vim.keymap.set('n', '<leader>cs', ':let @/ = ""<CR>', { silent = true })

-- start search and replace
vim.keymap.set('n', '<leader>sb', ':%s/')
vim.keymap.set('n', '<leader>sl', ':s/')
vim.keymap.set('v', '<leader>sb', ":s/", { noremap = true })

vim.keymap.set('n', '<F5>', ':setlocal spell!<CR>', { silent = true })
vim.opt.spelllang = 'en_us,es,ru'

-- create file under cursor
vim.keymap.set(
	'n',
	'<leader>gf',
	[[V:!xargs -I {} sh -c 'touch {}; echo {}'<CR>]],
	{ silent = true }
)

-- open config.
vim.keymap.set('n', '<leader>se', function()
        vim.cmd.tabedit(vim.fn.stdpath('config') .. '/lua/config/init.lua')
        vim.cmd.tchdir(vim.fn.stdpath('config'))
    end,
    {
        silent = true,
    }
)
