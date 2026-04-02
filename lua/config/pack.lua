-- common dependencies
vim.pack.add({'https://github.com/nvim-tree/nvim-web-devicons'})

require 'config.plugin.treesitter'

require 'config.plugin.oil'

vim.schedule(function()
    require 'config.plugin.fzf'

    -- other ui plugins
    vim.pack.add({
        'https://github.com/lukas-reineke/indent-blankline.nvim',
        'https://github.com/sphamba/smear-cursor.nvim',
    })

    require('ibl').setup()
    require('smear_cursor').setup()

    -- git integration
    vim.pack.add({
        'https://github.com/tpope/vim-fugitive',
        'https://github.com/lewis6991/gitsigns.nvim',
    })

    require 'config.plugin.mason'
end)

vim.api.nvim_create_autocmd('InsertEnter', {
    once = true,
    callback = function()
        require 'config.plugin.blink'
    end
})
