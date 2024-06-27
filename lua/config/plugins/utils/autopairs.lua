return {
    lazy = true,
    event = "InsertEnter",
    "windwp/nvim-autopairs",
    init = function() require("nvim-autopairs").setup {} end
}
