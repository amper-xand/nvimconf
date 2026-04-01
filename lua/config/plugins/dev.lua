return {
    -- auto completion
    {
        'saghen/blink.cmp',
        version = '*',
        event = "InsertEnter",
        opts = {

            keymap = {
                preset = 'default',

                ['<C-l>'] = { 'accept', 'fallback' },
            },

            cmdline = { enabled = false },
            sources = {
                default = { 'lsp', 'path', 'snippets', },
            },

            fuzzy = {
                sorts = {
                    'score', 'kind', 'label',
                },
            },

        },

        opts_extend = { 'sources.default' },
    },

    -- debugging
    {
        'mfussenegger/nvim-dap',

        ft = { 'cpp', 'c' },

        dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },

        config = function()
            local dap, dapui = require('dap'), require('dapui')

            local last_launch = nil

            local select_executable = function()
                local path = vim.fn.input({
                    prompt = "Start debugging  ",
                    default = vim.fn.getcwd() .. '/',
                    completion = 'file',
                })

                if path and path ~= '' then
                    last_launch = path

                    return path
                end

                return dap.ABORT
            end

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--quiet", "--interpreter=dap", "--eval-command", "set print pretty on", }
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    MIMode = "gdb",
                    request = "launch",
                    program = select_executable,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                },
                {
                    name = "Relaunch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        if last_launch == nil then
                            return select_executable()
                        end

                        return last_launch
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                },
            }

            vim.keymap.set('n', '\\b', dap.toggle_breakpoint, { noremap = false, silent = true })
            vim.keymap.set('n', '\\k', function() pcall(require("dapui").eval) end,
                { silent = true })

            vim.keymap.set('n', '\\c', dap.continue, { noremap = false, silent = true })
            vim.keymap.set('n', '\\o', dap.step_over, { silent = true })
            vim.keymap.set('n', '\\i', dap.step_into, { silent = true })
            vim.keymap.set('n', '\\f', dap.step_out, { silent = true })

            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
            dapui.setup()
        end
    },
    -- Git integration
    {
        'tpope/vim-fugitive',
    },
    {
        'lewis6991/gitsigns.nvim',
    },

    -- Mason to handle LSP instalations
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ensure_installed = { "lua-language-server" },
                automatic_installation = true,
            })
        end
    },
}
