vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local ensure_installed = {
    "bash", "diff", "json", "lua", "luadoc", "luap", "markdown", "markdown_inline", "printf",
    "python", "query", "regex", "toml", "vim", "vimdoc", "xml", "yaml", "c", "cpp",
}

local already_installed = require("nvim-treesitter.config").get_installed()

local parsers_to_install = vim.iter(ensure_installed)
    :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
    :totable()

require("nvim-treesitter").install(parsers_to_install)

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-context' })
