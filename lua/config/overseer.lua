local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'OverseerList')

function CONFIG.setup()
    -- local qf_height =
    local EFM_PYTHON = [[ %*\sFile \"%f\"\, line %l\, %m, ]]
    local overseer = require("overseer")
    local conf = {
        strategy = "terminal",
        auto_detect_success_color = true,
        actions = {
            -- instead of: overseer.nvim/lua/overseer/task_list/actions.lua
            ["open output in quickfix"] = {
                desc = "open the entire task output in quickfix",
                condition = function(task)
                    local bufnr = task:get_bufnr()
                    return task:is_complete()
                        and bufnr
                        and vim.api.nvim_buf_is_valid(bufnr)
                        and vim.api.nvim_buf_is_loaded(bufnr)
                end,
                run = function(task)
                    local lines = vim.api.nvim_buf_get_lines(task:get_bufnr(), 0, -1, true)
                    for i=#lines, 1, -1 do
                        if lines[i] == "" then
                            table.remove(lines, i)
                        else
                            break
                        end
                    end
                    vim.fn.setqflist({}, " ", {
                        title = task.name,
                        context = task.name,
                        lines = lines,
                        -- Peep into the default component params to fetch the errorformat
                        efm = task.default_component_params.errorformat,
                    })
                    vim.cmd("botright copen " .. _G.quickfix_bottom_height)
                end,
            },
        },
        task_list = {
            default_detail = 1,
            max_width = { 100, 0.2 },
            min_width = { _G.left_siderbar_width, 0.1 },
            max_height = { 20, 0.1 },
            min_height = 10,
            direction = "left",
            bindings = {
                ["<CR>"] = "RunAction",
                ["o"] = "Open",
                ["v"] = "OpenVsplit",
                ["x"] = "OpenSplit",
                ["E"] = "Edit",
                ["F"] = "OpenFloat",
                ["Q"] = "OpenQuickFix",
                ["p"] = "TogglePreview",
                ["<C-l>"] = nil,
                ["<C-h>"] = nil,
                ["L"] = "IncreaseDetail",
                ["H"] = "DecreaseDetail",
                ["["] = "DecreaseWidth",
                ["]"] = "IncreaseWidth",
                ["{"] = "PrevTask",
                ["}"] = "NextTask",
                ["<C-k>"] = "ScrollOutputUp",
                ["<C-j>"] = "ScrollOutputDown",
            }
        },
    }
    overseer.setup(conf)

    local on_output_quickfix = {
        'on_output_quickfix',
        tail = false,    -- Update the quickfix with task output as it happens, instead of waiting until completion
        open = false,    -- Open the quickfix on output
        close = true,   -- Close the quickfix on completion if no error
        open_height = _G.quickfix_bottom_height,  -- The height of the quickfix when opened
        open_on_exit = 'always',  -- Open the quickfix when the command exits "never"|"failure"|"always"
    }

    overseer.register_template({
        name = '0py',
        builder = function()
            local file = vim.fn.expand('%:p')
            local cmd = { 'python3' }
            return {
                cmd = cmd,
                args = { file },
                metadata = { run_cmd = string.format('%s %s', cmd[1], file) },
                components = {
                    'default',
                    on_output_quickfix,
                    { 'on_complete_notify', statuses = { 'FAILURE' } },
                },
                default_component_params = {
                    errorformat = EFM_PYTHON
                },
            }
        end,
        condition = {
            filetype = { 'python' },
        },
    })

    overseer.add_template_hook({ name = "make" }, function(task_defn, util)
        util.add_component(task_defn, on_output_quickfix)
    end)

    _G.custom_overseer_compile = function()
        local ft = vim.bo.filetype
        if ft == 'c' or ft == 'cpp' or ft == 'make'
        then
            overseer.run_template({ name = 'make' }, function(task)
                if task then
                    print('run make:', task:is_running(), task:is_disposed(), task:is_complete())
                    -- if task:is_complete() then
                    --     overseer.run_action(task, 'set quickfix diagnostics')
                    -- end
                end
            end)
        elseif ft == 'python'
        then
            overseer.run_template({ name = '0py' }, function(task)
                print('run python:' , task:is_running(), task:is_disposed(), task:is_complete())
            end)
        elseif ft == 'sh'
        then
            local task = overseer.new_task({
                cmd = { vim.fn.expand('%:p') },
                components = {
                    'default',
                    on_output_quickfix,
                    'on_result_diagnostics_quickfix',
                },
                default_component_params = {
                    errorformat = EFM_PYTHON .. [[ %m,%f:%l:%c ]]
                },
            })
            task:start()
        else
            local task = overseer.new_task({
                cmd = {'overseer_compile.sh'},
                args = { vim.fn.expand('%:p'), vim.bo.filetype },
                components = {'default', on_output_quickfix}
            })
            task:start()
        end
    end
end

return CONFIG
