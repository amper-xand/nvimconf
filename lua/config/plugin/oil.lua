vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require('oil').setup({
    float = { max_width = 0.7 }
})

vim.keymap.set('n', '<leader>e', require('oil').open)
vim.keymap.set('n', '<leader>fe', require('oil').toggle_float)
