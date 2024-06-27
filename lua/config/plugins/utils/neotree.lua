return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd          = "Neotree",
    lazy         = true,
    branch       = "v3.x",
    init         = function() vim.keymap.set('n', '<leader>te', ':Neotree toggle right<CR>', { silent = true }) end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-tree/nvim-web-devicons" }, -- not strictly required, but recommended
        { "MunifTanjim/nui.nvim" },
    }
}
