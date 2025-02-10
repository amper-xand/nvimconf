local diagnostic = vim.diagnostic

vim.keymap.set('n', '<space>e', diagnostic.open_float)
vim.keymap.set('n', '[d', diagnostic.goto_prev)
vim.keymap.set('n', ']d', diagnostic.goto_next)
vim.keymap.set('n', '<space>q', diagnostic.setloclist)

local lsp_autogroup = vim.api.nvim_create_augroup('UserLspConfig', {})

local set_lsp_actions = function(ev)
    local lsp = vim.lsp.buf
    local opts = { buffer = ev.buf }

    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- move based on symbols
    vim.keymap.set('n', 'gD', lsp.declaration, opts)
    vim.keymap.set('n', 'gd', lsp.definition, opts)
    vim.keymap.set('n', 'gi', lsp.implementation, opts)
    vim.keymap.set('n', 'gr', lsp.references, opts)
    vim.keymap.set('n', '<space>D', lsp.type_definition, opts)

    -- show documentation
    vim.keymap.set('n', 'K', lsp.hover, opts)
    vim.keymap.set('n', '<C-k>', lsp.signature_help, opts)

    -- workspace
    vim.keymap.set('n', '<space>wa', lsp.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', lsp.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(lsp.list_workspace_folders()))
    end, opts)

    -- actions that change files
    vim.keymap.set('n', '<space>rn', lsp.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', lsp.code_action, opts)
    vim.keymap.set('n', '<space>f', function() lsp.format { async = true } end, opts)

    -- show inlay hints while in insert mode
    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        callback = function() vim.lsp.inlay_hint.enable(true) end,
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        callback = function() vim.lsp.inlay_hint.enable(false) end,
    })

    vim.keymap.set('n', '<space>i', function()
        -- toggle inlay hints in normal mode
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)

    -- highlight occurrences under cursor
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
