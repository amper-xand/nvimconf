return {
    "amper-xand/idkhow.nvim",
    lazy = false,
    priority = 1000,

    init = function()
        vim.o.termguicolors = true
        vim.cmd [[colorscheme razzmatazz]]
    end,
}
