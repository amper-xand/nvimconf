return {
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter', },
        opts = {},
    },

    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        init = function()
            vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
            vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep)
            vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers)
            vim.keymap.set('n', '<leader>fs', require('fzf-lua').lgrep_curbuf)

            vim.keymap.set('n', '<leader>fh', require('fzf-lua').helptags)

            vim.keymap.set('n', '<leader>gg', require('fzf-lua').git_status)
        end,
    },

    {
        'stevearc/oil.nvim',
        opts = {
            float = { max_width = 0.7 }
        },
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        init = function()
            vim.keymap.set('n', '<leader>e', require('oil').open)
            vim.keymap.set('n', '<leader>fe', require('oil').toggle_float)
        end,
        lazy = false,
    },
}
