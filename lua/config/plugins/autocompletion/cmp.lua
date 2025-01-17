return {
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup

        impersonate_nvim_cmp = false,
        opts = {},
    },

    {
        'saghen/blink.cmp',
        version = '*',
        event = "InsertEnter",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {

            keymap = {
                preset = 'default',

                ['<C-l>'] = { 'accept', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },

            },

            sources = {
                cmdline = {},

                default = { 'lsp', 'path', 'snippets', 'buffer', 'vimtex' },

                providers = {
                    vimtex = {
                        name = 'vimtex',
                        module = 'blink.compat.source',
                    },
                },
            },

        },
        opts_extend = { 'sources.default' },

        dependencies = { 'micangl/cmp-vimtex' }
    }
}
