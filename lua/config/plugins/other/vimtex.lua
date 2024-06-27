return {
    "lervag/vimtex",
    --event = "BufEnter *.tex",
    config = function()
        vim.cmd 'filetype plugin indent on'
        vim.g.vimtex_view_general_viewer = '/mnt/c/Users/andres/AppData/Local/SumatraPDF/SumatraPDF.exe'
        vim.g.vimtex_view_general_options = '@pdf'

        vim.cmd [[
        let g:vimtex_compiler_latexmk = {
            \ 'out_dir' : './build',
            \}
            ]]

        vim.g.vimtex_mappings_enabled = 1

        --vim.g.tex_fast = ""
    end
}
