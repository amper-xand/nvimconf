vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true },
})

local lsp_autogroup = vim.api.nvim_create_augroup('UserLspConfig', {})

local setup_lsp_on_attach = function(ev)
    vim.lsp.completion.enable(
        true,
        ev.data.client_id,
        ev.buf,
        { autotrigger = false }
    )

    local lsp_buf = vim.lsp.buf
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', '<space>f', function() lsp_buf.format { async = true } end, opts)
    vim.keymap.set('n', 'grs', lsp_buf.signature_help, opts)
    vim.keymap.set('n', 'grt', lsp_buf.type_definition, opts)

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

    -- highlight occurrences under cursor
    if vim.lsp.get_client_by_id(ev.data.client_id):supports_method('textDocument/documentHighlight') then
        vim.opt.updatetime = 100

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = lsp_autogroup,
            callback = vim.lsp.buf.document_highlight
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = ev.buf,
            group = lsp_autogroup,
            callback = vim.lsp.buf.clear_references
        })
    end
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
                globals = { 'vim' },
            },
            workspace = {
                -- make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("lua", true),
            },
            signatureHelp = { enabled = true },
        },
    },
}

vim.lsp.config.tinymist = {
    cmd = { 'tinymist' },
    filetypes = { 'typst', 'typ' },
    root_markers = { '.git' },
    settings = {
        formatterMode = 'typstyle',
        formatterIndentSize = 4,
        lint = {
            enabled = true,
        }
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
                onSave = false,
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
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/basedpyright-langserver', '--stdio' },
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

vim.lsp.config.rustanalyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust', 'rs' },
}

vim.lsp.config.Rlang = {
    cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
    filetypes = { 'r', 'rmd' },
}

vim.lsp.enable({
    'luals',
    'tinymist',
    'texlab',
    'clangd',
    'basedpyright',
    'rustanalyzer',
    'Rlang',
})
