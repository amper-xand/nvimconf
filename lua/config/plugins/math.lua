return {
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.cmd.filetype('plugin indent on')
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]

            vim.g.vimtex_compiler_latexmk = {
                aux_dir = './build'
            }

            vim.g.vimtex_mappings_enabled = 1

            --vim.g.tex_fast = ""
        end
    }
}
