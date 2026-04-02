vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') } })

require('blink.cmp').setup({
    keymap = {
        preset = 'default',

        ['<C-l>'] = { 'accept', 'fallback' },
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

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 300,
        }
    }
})
