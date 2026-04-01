-- common dependencies
vim.pack.add({'https://github.com/nvim-tree/nvim-web-devicons'})

require 'config.plugin.oil'
require 'config.plugin.fzf'

vim.schedule(function()
    require 'config.plugin.mason'
end)
