vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep)
vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers)
vim.keymap.set('n', '<leader>fs', require('fzf-lua').lgrep_curbuf)

vim.keymap.set('n', '<leader>fh', require('fzf-lua').helptags)

vim.keymap.set('n', '<leader>gg', require('fzf-lua').git_status)
