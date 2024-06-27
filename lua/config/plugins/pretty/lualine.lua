return {
    'nvim-lualine/lualine.nvim',
    init = function()
        local wpm = require("wpm") -- Not Maintained
        wpm.setup()
        require('lualine').setup({
            tabline = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = { 'tabs' },
                lualine_x = {},
                lualine_y = { 'buffers' },
                --lualine_z = {'filename'}
            },
            sections = {
                lualine_x = { wpm.wpm, wpm.historic_graph, 'encoding', 'fileformat', 'filetype' },
            }
        })
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons', 'jcdickinson/wpm.nvim' }
}
