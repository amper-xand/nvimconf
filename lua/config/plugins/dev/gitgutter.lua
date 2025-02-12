return {
    "airblade/vim-gitgutter",

    init = function ()
        vim.opt.signcolumn = 'yes'

        vim.keymap.set('n', ']e', ':GitGutterNextHunk<CR>')
        vim.keymap.set('n', '[e', ':GitGutterPrevHunk<CR>')
        vim.keymap.set('n', '<leader>ph', ':GitGutterPreviewHunk<CR>')
        vim.keymap.set('n', '<leader>sh', ':GitGutterStageHunk<CR>')
    end
}
