local readers = {
    wsl = {
        cmd = '/mnt/c/Users/andres/AppData/Local/SumatraPDF/SumatraPDF.exe',
        general_options = '@pdf',
    },
    windows = {
        cmd = 'SumatraPDF',
        general_options = '@pdf',
    },
    linux = {
        cmd = 'okular',
        general_options = [[--unique file:@pdf\#src:@line@tex]]
    },
}

local selected_reader = readers.linux

if vim.loop.os_uname().sysname == "Windows_NT" then
    selected_reader = readers.windows
end

return {
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = true,

        init = function()
            vim.g.typst_pdf_viewer = selected_reader.cmd

            vim.g.typst_conceal = true

            vim.api.nvim_create_autocmd('BufReadPre', {
                pattern = '*.typ',
                callback = function(ev)
                    vim.api.nvim_buf_set_keymap(ev.buf, 'n', '<leader>ll', ':silent! TypstWatch<CR>', { silent = true })
                end
            })
        end
    },

    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.cmd.filetype('plugin indent on')
            vim.g.vimtex_view_general_viewer = selected_reader.cmd
            vim.g.vimtex_view_general_options = selected_reader.general_options

            vim.g.vimtex_compiler_latexmk = {
                aux_dir = './build'
            }

            vim.g.vimtex_mappings_enabled = 1

            --vim.g.tex_fast = ""
        end
    }
}
