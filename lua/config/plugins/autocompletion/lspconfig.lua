return {
    "neovim/nvim-lspconfig",
    envent = "BuffPreRead",
    init = function()
        -- Setup language servers.

        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    update_in_insert = false
                }
            )

        vim.lsp.inlay_hint.enable(true)

        local lspconfig = require('lspconfig')
        -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        local lsp_capabilities = vim.tbl_deep_extend("force",
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )

        lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

        lspconfig.clangd.setup { capabilities = lsp_capabilities, compilationDatabasePath = './', cmd = { "clangd", "--clang-tidy" } }
        lspconfig.cmake.setup { capabilities = lsp_capabilities }
        lspconfig.pyright.setup { capabilities = lsp_capabilities }
        lspconfig.texlab.setup { capabilities = lsp_capabilities }
        lspconfig.typos_lsp.setup { filetypes = "tex", init_options = { diagnosticSeverity = "Hint" } }

        lspconfig.gopls.setup { capabilities = lsp_capabilities }
        lspconfig.html.setup { capabilities = lsp_capabilities }
        lspconfig.cssls.setup { capabilities = lsp_capabilities }
        lspconfig.lua_ls.setup { capabilities = lsp_capabilities }

        lspconfig.pyright.setup { capabilities = lsp_capabilities }
    end
}
