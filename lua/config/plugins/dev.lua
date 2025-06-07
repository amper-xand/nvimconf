return {
    -- auto completion
    {
        'saghen/blink.cmp',
        version = '*',
        event = "InsertEnter",
        opts = {

            keymap = {
                preset = 'default',

                ['<C-l>'] = { 'accept', 'fallback' },
                -- ['<C-k>'] = { 'select_prev', 'fallback' },
                -- ['<C-j>'] = { 'select_next', 'fallback' },
            },

            cmdline = { enabled = false },
            sources = {
                default = { 'lsp', 'path', 'snippets', },
            },

            fuzzy = {
                sorts = {
                    'score', 'kind', 'label',
                },
            },

        },

        opts_extend = { 'sources.default' },
    },

    -- Git integration
    {
        'tpope/vim-fugitive',
    },
    {
        'lewis6991/gitsigns.nvim',
    },

    -- Mason to handle LSP instalations
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ensure_installed = { "lua-language-server" },
                automatic_installation = true,
            })
        end
    },
}
