local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'TelescopePrompt')

function CONFIG.setup()
    local util = require('utils')
    local binary_files = require('utils.constant').binary_files
    local actions = require("telescope.actions")
    local nvb_actions = require("telescope.actions.mt").transform_mod {
        file_path = function(prompt_bufnr)
            -- Get selected entry and the file full path
            local content = require("telescope.actions.state").get_selected_entry()
            local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

            -- Yank the path to unnamed and clipboard registers
            vim.fn.setreg('"', full_path)
            vim.fn.setreg("+", full_path)

            -- Close the popup
            require("utils").info "File path is yanked "
            actions.close(prompt_bufnr)
        end,

        open_term = function(prompt_bufnr)
            -- Get the full path
            local content = require("telescope.actions.state").get_selected_entry()
            local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

            -- Close the Telescope window
            actions.close(prompt_bufnr)
            require('lspsaga.floaterm'):open_float_terminal({os.getenv('SHELL'), util.dirname(full_path)})
        end,

        delete_buff = function(prompt_bufnr)
            actions.delete_buffer(prompt_bufnr)
        end,
    }

    local find_files_command = {
        'rg',
        '--files',
        -- '--hidden',
        '-g', '!.git',
    }

    local git_files_command = {
        'git',
        'ls-files',
        '--recurse-submodules',
        '--exclude-standard',
        '--cached',
        '--',
        '.',
        ':!:out',
    }

    for _, glob in pairs(binary_files) do
        table.insert(find_files_command, '-g')
        table.insert(find_files_command, '!' .. glob)
        table.insert(git_files_command, ':!:' .. glob)
    end

    -- initial_mode: insert, normal
    -- local trouble = require("trouble.providers.telescope")
    local conf = {
        defaults = {
            prompt_prefix = require("utils.icons").ui.Telescope .. " ",
            selection_caret = " ",
            path_display = { "smart" },
            initial_mode = "normal",
            layout_strategy = "vertical", -- horizontal
            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-c>"] = actions.close,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ---@diagnostic disable-next-line: unused-local
                    ["<Tab>"] = function(prompt_bufnr)
                        -- print(vim.api.nvim_get_mode().mode)
                        vim.api.nvim_input('<ESC>')
                        -- return actions.move_selection_previous(prompt_bufnr)
                    end,
                    ["<S-Tab>"] = actions.move_selection_next,
                    -- qflist: "cn/ cp" for grep; "cnf/cpf" for find
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

                    ["<RightMouse>"] = actions.close,
                    ["<LeftMouse>"] = actions.select_default,
                    ["<ScrollWheelDown>"] = actions.move_selection_next,
                    ["<ScrollWheelUp>"] = actions.move_selection_previous,
                },

                n = {
                    ["<esc>"] = actions.close,
                    ["q"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["o"] = actions.select_default,
                    ["x"] = actions.select_horizontal,
                    ["v"] = actions.select_vertical,
                    ["t"] = actions.select_tab,
                    ["<RightMouse>"] = actions.close,
                    ["<LeftMouse>"] = actions.select_default,
                    ["<ScrollWheelDown>"] = actions.move_selection_next,
                    ["<ScrollWheelUp>"] = actions.move_selection_previous,

                    -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<Tab>"] = actions.move_selection_previous,
                    ["<S-Tab>"] = actions.move_selection_next,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,
                    -- [",xx"] = trouble.open_with_trouble,

                    ["?"] = actions.which_key,
                },
            },
            history = {
                path = _G.nvim_cache_path .. "/telescope_history.sqlite3",
                limit = 120,
            },
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
        },
        pickers = {
            oldfiles = { initial_mode = "normal", previewer = false, },
            jumplist = { initial_mode = "normal" },
            marks = {
                initial_mode = "normal",
                mark_type = "all",
                previewer = true,
                layout_config = {
                    prompt_position = "bottom",
                    height = 0.90,
                    width = 0.90
                },
                mappings = {
                    n = {
                        ["dd"] = actions.delete_mark,
                    },
                },
            },
            registers = { initial_mode = "normal" },
            grep_string = { initial_mode = "normal", previewer = true },
            find_files = {
                -- theme = "ivy",
                initial_mode = "insert",
                previewer = false,
                mappings = {
                    n = {
                        ["y"] = nvb_actions.file_path,
                        ["\\"] = nvb_actions.open_term,
                    },
                    i = {
                        ["<C-y>"] = nvb_actions.file_path,
                    },
                },
                hidden = false,
                find_command = find_files_command,
            },
            git_status = { initial_mode = "normal", },
            git_files = {
                -- theme = "dropdown",
                initial_mode = "normal",
                use_git_root = true,
                previewer = true,
                mappings = {
                    n = {
                        ["y"] = nvb_actions.file_path,
                        ["\\"] = nvb_actions.open_term,
                    },
                    i = {
                        ["<C-y>"] = nvb_actions.file_path,
                    },
                },
                git_command = git_files_command,
            },
            buffers = {
                theme = "dropdown",
                initial_mode = "normal",
                previewer = false,
                layout_config = {
                    prompt_position = "top",
                    height = 0.99,
                    width = 0.99
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    }

    require("telescope").setup(conf)
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('projects') -- project.nvim

    -- require('telescope').load_extension('neoclip')
    -- require('telescope').load_extension('macroscope')
    -- require('telescope').load_extension('vim_bookmarks')

    _G.custom_telescope_find_files = function()-- {{{
        local opts = { prompt_title = "Git Files" }
        local telescope = require "telescope.builtin"
        local ok = pcall(telescope.git_files, opts)
        if not ok then
            opts.prompt_title = "Find Files"
            telescope.find_files(opts)
        end
    end-- }}}

    _G.custom_git_grep_string = function()-- {{{
        local word = vim.fn.expand('<cword>')
        local opts = {
            grep_open_files = false,
            initial_mode = "normal",
            layout_config = {
                prompt_position = "bottom",
                height = 0.85,
                width = 0.85
            }
        }
        local git_dir = util.wsdir(vim.fn.expand("%:p:h"))
        if #git_dir > 2 then
            opts.prompt_title = string.format("Git Search(%s:%s)", util.basename(git_dir), word)
            opts.cwd = git_dir
        else
            opts.prompt_title = string.format("Search(%s:%s)", util.basename(git_dir), word)
        end
        require('telescope.builtin').grep_string(opts)
    end-- }}}

    _G.custom_git_live_grep = function()-- {{{
        local prefix = 'Live Grep'
        local opts = { grep_open_files = false, initial_mode = "insert"}
        local search_path = vim.fn.expand("%:p:h")
        local git_dir = util.wsdir(search_path)
        if #git_dir > 2 then
            opts.prompt_title = string.format("%s (git: %s)", prefix, util.basename(git_dir))
            opts.cwd = git_dir
        else
            opts.prompt_title = string.format("%s (cur: %s)", prefix, util.basename(search_path))
        end
        require('telescope.builtin').live_grep(opts)
    end-- }}}
end

return CONFIG
