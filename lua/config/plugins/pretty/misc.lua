-- various plugins
-- that have too small configs for them to have their own file

return {
    -- {
    --     "https://github.com/cocopon/colorswatch.vim"
    -- },

    -- {
    --     "brenoprata10/nvim-highlight-colors",
    --     init = function()
    --         require('nvim-highlight-colors').setup({})
    --     end
    -- },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    {
        "nvim-tree/nvim-web-devicons",
        init = function()
            require 'nvim-web-devicons'.setup {
                override_by_extension = {
                    typ = {
                        icon = '󰍘',
                    }
                }
            }
        end
    },
}
