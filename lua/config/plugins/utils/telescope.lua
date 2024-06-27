return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    lazy = true,
    init = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, {})

        vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
        vim.keymap.set('n', '<leader>fR', builtin.registers, {})

        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}
