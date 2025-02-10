return {
    lazy = true,
    event = "InsertEnter",
    "windwp/nvim-autopairs",
    init = function()
        local npairs = require('nvim-autopairs')

        npairs.setup({})

        local Rule = require('nvim-autopairs.rule')

        npairs.add_rule(
            Rule('$', '$', {'tex', 'latex', 'typst', 'typ'})
        )
    end
}
