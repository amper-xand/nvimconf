vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })

require('mason').setup({
    ensure_installed = { "lua-language-server" },
    automatic_installation = true,
})
