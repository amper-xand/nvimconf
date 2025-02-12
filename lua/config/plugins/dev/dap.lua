return {
    'mfussenegger/nvim-dap',

    dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },

    event = "VeryLazy",

    config = function()
        local dap, dapui = require("dap"), require("dapui")

        local last_launch

        local telescope_executable = function()
            local pickers = require("telescope.pickers")
            local finders = require("telescope.finders")
            local conf = require("telescope.config").values
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            return coroutine.create(function(coro)
                local opts = {}
                pickers.new(opts, {
                    prompt_title = "Path to executable",

                    finder = finders.new_oneshot_job({ "find", ".", "-type", "f", "-executable" }, {}),
                    sorter = conf.generic_sorter(opts),

                    attach_mappings = function(buffer_number)
                        actions.select_default:replace(function()
                            actions.close(buffer_number)

                            local selection = action_state.get_selected_entry()[1]

                            last_launch = selection

                            coroutine.resume(coro, selection)
                        end)
                        return true
                    end,
                })
                    :find()
            end)
        end

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = telescope_executable,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Relaunch",
                type = "gdb",
                request = "launch",
                program = function()
                    if last_launch == nil then
                        return telescope_executable()
                    end

                    return last_launch
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }

        dap.configurations.c = dap.configurations.cpp

        vim.keymap.set('n', '<leader><leader>b', dap.toggle_breakpoint, { noremap = false, silent = true })
        vim.keymap.set('n', '<leader><leader>c', dap.continue, { noremap = false, silent = true })
        vim.keymap.set('n', '<leader><leader>k', function() pcall(require("dapui").eval) end, { silent = true })

        -- inspect variables with K
        local keymap_restore = {}
        local session_keys = {}

        local session_map = function(key, rhs, opts)
            table.insert(session_keys, { key = key, rhs = rhs, opts = opts })
        end

        session_map('<F1>', dap.step_over, { silent = true })
        session_map('<F2>', dap.step_into, { silent = true })
        session_map('<F3>', dap.step_out, { silent = true })
        session_map('<F4>', dap.step_back, { silent = true })

        dap.listeners.after.event_initialized['me'] = function()
            local set_key = function(key, rhs, opts)
                for _, buf in pairs(vim.api.nvim_list_bufs()) do
                    local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')

                    for _, keymap in pairs(keymaps) do
                        if keymap.lhs == key then
                            -- store prev keymap
                            table.insert(keymap_restore, keymap)
                            vim.api.nvim_buf_del_keymap(buf, 'n', keymap.lhs)
                        end
                    end
                end

                vim.keymap.set('n', key, rhs, opts)
            end

            for _, keymap in pairs(session_keys) do
                set_key(keymap.key, keymap.rhs, keymap.opts)
            end
        end

        dap.listeners.after.event_terminated['me'] = function()
            -- remove temporary keymaps
            for _, keymap in pairs(session_keys) do
                vim.keymap.del('n', keymap.key)
            end

            -- restore keymaps after session

            for _, keymap in pairs(keymap_restore) do
                if keymap.rhs then
                    vim.api.nvim_buf_set_keymap(
                        keymap.buffer,
                        keymap.mode,
                        keymap.lhs,
                        keymap.rhs,
                        { silent = keymap.silent == 1 }
                    )
                elseif keymap.callback then
                    vim.keymap.set(
                        keymap.mode,
                        keymap.lhs,
                        keymap.callback,
                        { buffer = keymap.buffer, silent = keymap.silent == 1 }
                    )
                end
            end

            keymap_restore = {}
        end

        dapui.setup()
        dap.listeners.before.attach.dapui_config           = dapui.open
        dap.listeners.before.launch.dapui_config           = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config     = dapui.close
    end,
}
