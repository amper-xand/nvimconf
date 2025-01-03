return {
    require "config.plugins.autocompletion.cmp",
    require "config.plugins.autocompletion.lspconfig",
    require "config.plugins.autocompletion.lazydev",

    require "config.plugins.pretty.lualine",
    require "config.plugins.pretty.idkhow",
    require "config.plugins.pretty.treesitter",
    require "config.plugins.pretty.misc",

    require "config.plugins.utils.autopairs",
    require "config.plugins.utils.neotree",
    require "config.plugins.utils.telescope",
    require "config.plugins.utils.gitgutter",

    require "config.plugins.other.vimtex",
    require "config.plugins.other.trouble",

    ---------------- Startup ----------------
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
}
