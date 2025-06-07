-- - "grn"   is mapped in Normal mode to            |vim.lsp.buf.rename()|
-- - "gra"   is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "grr"   is mapped in Normal mode to            |vim.lsp.buf.references()|
-- - "gri"   is mapped in Normal mode to            |vim.lsp.buf.implementation()|
-- - "gO"    is mapped in Normal mode to            |vim.lsp.buf.document_symbol()|
-- -  CTRL-S is mapped in Insert mode to            |vim.lsp.buf.signature_help()|

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true }
})

local lsp_autogroup = vim.api.nvim_create_augroup('UserLspConfig', {})

local set_maps = function(ev)
    local lsp_buf = vim.lsp.buf
    local opts = { buffer = ev.buf }

    -- autocompletion
    -- vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {autotrigger=false})

    vim.keymap.set('n', '<space>f', function() lsp_buf.format { async = true } end, opts)
    vim.keymap.set('n', 'grs', lsp_buf.signature_help, opts)
    vim.keymap.set('n', 'grt', lsp_buf.type_definition, opts)

    vim.keymap.set('n', 'grc', function()
        ---@param options vim.lsp.LocationOpts.OnList
        local function add_symbols(options)
            vim.fn.setloclist(0, {}, 'r', options)
        end

        lsp_buf.document_symbol({ on_list = add_symbols })
    end, opts)

    -- show inlay hints while in insert mode
    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        buffer = ev.buf,
        callback = function() vim.lsp.inlay_hint.enable(true) end,
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        buffer = ev.buf,
        callback = function() vim.lsp.inlay_hint.enable(false) end,
    })

    vim.keymap.set('n', '<space>i', function()
        -- toggle inlay hints in normal mode
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)

    if vim.lsp.get_client_by_id(ev.data.client_id):supports_method('textDocument/signatureHelp') then
        vim.api.nvim_create_autocmd({ 'CursorHoldI' }, {
            buffer = ev.buf,
            group = lsp_autogroup,
            callback = function()
                vim.lsp.buf.signature_help({ max_height = 3, offset_y = 1000, relative = "editor", focusable = false })
            end
        })
    end

    -- highlight occurrences under cursor
    if vim.lsp.get_client_by_id(ev.data.client_id):supports_method('textDocument/documentHighlight') then
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
    callback = set_maps,
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
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("lua", true),
            },
            signatureHelp = { enabled = true },
        },
    },
}

vim.lsp.config.tinymist = {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
    root_markers = { '.git' },
    settings = {
        formatterMode = "typstyle",
        formatterIndentSize = 4,
        -- exportPdf = "onSave",
        -- lint = {
        --     enabled = true,
        -- }
    }
}

vim.lsp.config.texlab = {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'latex' },
    root_markers = { '.git' },
    settings = {
        texlab = {
            rootDirectory = '.',
            build = {
                executable = 'latexmk',
                pdfDirectory = 'build',
                auxDirectory = 'build',
                args = { '-outdir=build', '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = 'okular',
                args = {
                    '--unique',
                    '%p'
                },
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 80,
        },
    }
}

vim.lsp.config.clangd = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = { '.clangd', 'compile_commands.json' },
}

vim.lsp.config.basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.git', '.venv' },
    settings = {
        reportUnknownMemberType = 'hint',
        basedpyright = {
            python = {
                pythonPath = '.venv/bin/python',
            },
            analysis = {
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'standard',
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,

                inlayHints = {
                    callArgumentNames = true
                }
            }
        }
    }
}


vim.lsp.enable({
    'luals',
    'tinymist',
    'texlab',
    'clangd',
    'basedpyright',
})
