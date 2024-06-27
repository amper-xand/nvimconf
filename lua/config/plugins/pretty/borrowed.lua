return {
    "myypo/borrowed.nvim",
    lazy = false,
    priority = 1000,


    config = function()
        require("borrowed").setup({
            specs = {
                all = {
                    syntax = {
                        --func = "yell",
                    },
                },
            },
        })

        vim.cmd("colorscheme shin")
    end,
}
