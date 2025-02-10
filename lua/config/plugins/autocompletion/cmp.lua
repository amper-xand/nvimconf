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

                default = { 'lsp', 'path', 'snippets', 'buffer', 'vimtex', 'spell' },

                providers = {
                    vimtex = {
                        name = 'vimtex',
                        module = 'blink.compat.source',
                    },

                    spell = {
                        name = 'Spell',
                        module = 'blink-cmp-spell',
                    },
                },
            },

            fuzzy = {
                sorts = {
                    function(a, b)
                        if a.source_id == 'spell' and b.source_id == 'spell' then
                            return require('blink.cmp.fuzzy.sort').label(a, b)
                        end
                    end,
                    'score', 'kind', 'label',
                },
            },

        },

        opts_extend = { 'sources.default' },

        dependencies = { 'micangl/cmp-vimtex', 'ribru17/blink-cmp-spell', }
    }
}
