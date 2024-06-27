return {
    require "config.plugins.autocompletion.cmp",
    require "config.plugins.autocompletion.lspconfig",
    require "config.plugins.autocompletion.lazydev",

    require "config.plugins.pretty.lualine",
    require "config.plugins.pretty.borrowed",
    require "config.plugins.pretty.treesitter",
    require "config.plugins.pretty.colorswatch",
    require "config.plugins.pretty.markview",
    require "config.plugins.pretty.todo-comment",

    require "config.plugins.utils.autopairs",
    require "config.plugins.utils.neotree",
    require "config.plugins.utils.telescope",

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