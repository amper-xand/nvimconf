return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    lazy = true,
    init = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope fuzzy find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope fuzzy find buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope fuzzy find help tags" })

        vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find,
            { desc = "Telescope current buffer fuzzy find" })

        vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "Telescope fuzzy find quickfix" })
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope fuzzy find jumplist" })
        vim.keymap.set('n', '<leader>fR', builtin.registers, { desc = "Telescope fuzzy find registers" })

        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "Telescope fuzzy find lsp references" })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Telescope fuzzy find diagnostics" })

        vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = "Telescope fuzzy find with git status" })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}
