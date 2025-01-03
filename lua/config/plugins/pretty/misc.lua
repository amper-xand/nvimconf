-- various plugins
-- that have too small configs for them to have their own file

return {
    {
        "https://github.com/cocopon/colorswatch.vim"
    },

    {
        "brenoprata10/nvim-highlight-colors",
        init = function()
            require('nvim-highlight-colors').setup({})
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
}
