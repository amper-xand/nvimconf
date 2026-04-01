vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true }
})

local lsp_autogroup = vim.api.nvim_create_augroup('UserLspConfig', {})

local setup_lsp_on_attach = function(ev)

    vim.lsp.completion.enable(
        true,
        ev.data.client_id,
        ev.buf,
        {autotrigger=false}
    )
    
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_autogroup,
    callback = setup_lsp_on_attach,
})

vim.lsp.config.luals = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    telemetry = { enabled = false },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                -- get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("lua", true),
            },
            signatureHelp = { enabled = true },
        },
    },
}

vim.lsp.enable({
    'luals',
})
