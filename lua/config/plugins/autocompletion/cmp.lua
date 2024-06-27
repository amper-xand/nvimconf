return {
    "hrsh7th/nvim-cmp",
    init = function()
        local cmp = require 'cmp'

        vim.opt.completeopt = "menu,menuone,noselect"

        vim.cmd [[
        " Jump forward or backward
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        ]]

        cmp.setup({
            formatting = {
                format = require('lspkind').cmp_format(),
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<C-l>"] = cmp.mapping({
                    -- i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        elseif not cmp.confirm({ select = true }) then
                            vim.api.nvim_feedkeys('\r', 'n', false)
                        else
                            fallback()
                        end
                    end,
                }),
            }),

            { performance = { debounce = 200 } },
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- LSP
                { name = 'vsnip' },
                { name = 'vimtex' }
            }),
        })
    end,
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', "micangl/cmp-vimtex", "onsails/lspkind.nvim" }
}
