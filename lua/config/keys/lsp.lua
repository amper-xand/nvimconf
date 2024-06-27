local map = vim.keymap.set

local diagnostic = vim.diagnostic

map('n', '<space>e', diagnostic.open_float)
map('n', '[d', diagnostic.goto_prev)
map('n', ']d', diagnostic.goto_next)
map('n', '<space>q', diagnostic.setloclist)

local lsp_autogroup = vim.api.nvim_create_augroup('UserLspConfig', {})

local set_lsp_actions = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local lsp = vim.lsp.buf

    local opts = { buffer = ev.buf }
    map('n', 'gD', lsp.declaration, opts)
    map('n', 'gd', lsp.definition, opts)

    map('n', 'K', lsp.hover, opts)
    map('n', 'gi', lsp.implementation, opts)
    map('n', '<C-k>', lsp.signature_help, opts)

    map('n', '<space>wa', lsp.add_workspace_folder, opts)
    map('n', '<space>wr', lsp.remove_workspace_folder, opts)
    map('n', '<space>wl', function()
        print(vim.inspect(lsp.list_workspace_folders()))
    end, opts)

    map('n', '<space>D', lsp.type_definition, opts)
    map('n', '<space>rn', lsp.rename, opts)
    map({ 'n', 'v' }, '<space>ca', lsp.code_action, opts)
    map('n', 'gr', lsp.references, opts)
    map('n', '<space>f', function()
        lsp.format { async = true }
    end, opts)

    map('n', '<space>i', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)

    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        callback = function() vim.lsp.inlay_hint.enable(true) end,
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        callback = function() vim.lsp.inlay_hint.enable(false) end,
    })

    if vim.lsp.get_client_by_id(ev.data.client_id).supports_method('textDocument/documentHighlight') then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = lsp_autogroup,
            callback = vim.lsp.buf.document_highlight
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = ev.buf,
            group = lsp_autogroup,
            callback = vim.lsp.buf.clear_references
        })
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_autogroup,
    callback = set_lsp_actions,
})
