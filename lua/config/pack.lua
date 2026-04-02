-- common dependencies
vim.pack.add({'https://github.com/nvim-tree/nvim-web-devicons'})

require 'config.plugin.treesitter'

require 'config.plugin.oil'
require 'config.plugin.fzf'

vim.schedule(function()
    -- other ui plugins
    vim.pack.add({
        'https://github.com/lukas-reineke/indent-blankline.nvim',
        'https://github.com/sphamba/smear-cursor.nvim',
    })

    require('ibl').setup()
    require('smear_cursor').setup()

    require 'config.plugin.mason'
end)
