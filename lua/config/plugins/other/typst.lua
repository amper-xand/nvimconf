return {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = true,

    init = function()
        vim.g.typst_pdf_viewer = '/mnt/c/Users/andres/AppData/Local/SumatraPDF/SumatraPDF.exe'
        vim.g.typst_conceal = true

        vim.api.nvim_create_autocmd('BufReadPost', {
            pattern = '*.typ',
            callback = function(ev)
                vim.api.nvim_buf_set_keymap(ev.buf, 'n', '<leader>ll',  ':silent! TypstWatch<CR>', { silent = true })
            end
        })
    end
}
