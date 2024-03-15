---@diagnostic disable: undefined-field
local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'sagaoutline')
---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'sagafinder')
---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'sagacallhierarchy')
---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'sagadiagnostc')

function CONFIG.setup()
    local icons = require('utils.icons')
    local conf = {
        ui = {
            border = 'single',
            devicon = true,
            title = true,
            expand = '⊞',
            collapse = '⊟',
            code_action = icons.diagnostics.Hint,  -- 💡
            diagnostic = '🐞',
            actionfix = ' ',
            -- lines = { '┗', '┣', '┃', '━', '┏' },
            lines = { '╰', '├', '│', '─', '╭' },
            kind = {
                Class = { icons.symbols.Class, 'Include' },
                Method = { icons.symbols.Method, 'Function' },
                Property = { icons.symbols.Property, '@method' },
                Field = { icons.symbols.Field, '@field' },
                Function = { icons.symbols.Function, 'Function' },
                Variable = { icons.symbols.Variable, '@variable' },
            },
            imp_sign = '󰳛 ',
        },
        hover = {
            max_width = 0.9,
            max_height = 0.8,
            open_link = 'gx',
            open_cmd = '!chrome',
        },
        diagnostic = {
            show_code_action = true,
            show_layout = 'float',
            show_normal_height = 30,
            jump_num_shortcut = true,
            max_width = 0.8,
            max_height = 0.6,
            max_show_width = 0.9,
            max_show_height = 0.6,
            text_hl_follow = true,
            border_follow = true,
            extend_relatedInformation = false,
            diagnostic_only_current = false,
            keys = {
                exec_action = 'o',
                quit = 'q',
                toggle_or_jump = { '<CR>', '<TAB>' },
                quit_in_show = { 'q', '<ESC>' },
            },
        },
        code_action = {
            num_shortcut = true,
            show_server_name = false,
            extend_gitsigns = false,
            only_in_cursor = true,
            max_height = 0.3,
            keys = {
                quit = 'q',
                exec = '<CR>',
            },
        },
        lightbulb = {
            enable = true,
            sign = true,
            debounce = 10,
            sign_priority = 40,
            virtual_text = false,
            enable_in_insert = false,
        },
        scroll_preview = {
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        },
        request_timeout = 3000,
        finder = {
            max_height = 0.8,
            left_width = 0.3,
            methods = {},
            default = 'ref+imp',
            layout = 'float',
            silent = false,
            filter = {},
            sp_inexist = false,
            sp_global = false,
            ly_botright = false,
            keys = {
                shuttle = { '[w', 'p' },
                toggle_or_open = { '<CR>', 'o', '<2-LeftMouse>', '<TAB>' },
                vsplit = 'v',
                split = 'x',
                tabe = 't',
                tabnew = 'r',
                quit = 'q',
                close = '<C-c>k',
            },
        },
        definition = {
            width = 0.6,
            height = 0.5,
            keys = {
                edit = { '<CR>', 'o', '<2-LeftMouse>' },
                vsplit = 'v',
                split = 'x',
                tabe = 't',
                tabnew = 'r',
                quit = 'q',
                close = '<C-c>k',
            },
        },
        rename = {
            in_select = true,
            auto_save = false,
            project_max_width = 0.5,
            project_max_height = 0.5,
            keys = {
                quit = '<C-k>',
                exec = '<CR>',
                select = 'x',
            },
        },
        symbol_in_winbar = {
            enable = false,
            separator = ' ▸ ',
            hide_keyword = true,
            ignore_patterns = nil,
            show_file = false,
            folder_level = 1,
            color_mode = false,
            dely = 300,
        },
        outline = {
            win_position = 'right',
            win_width = _G.right_siderbar_width,
            auto_preview = false,
            detail = false,
            auto_close = true,
            close_after_jump = false,
            layout = 'normal',
            -- layout = 'float',
            -- max_height = 0.5,
            -- left_width = 0.5,
            keys = {
                jump = { '<CR>', 'o', '<2-LeftMouse>' },
                quit = 'q',
                toggle_or_jump = {'e', 'O'},
            },
        },
        callhierarchy = {
            layout = 'float',
            left_width = 0.4,
            keys = {
                edit = { '<CR>', 'o', '<2-LeftMouse>' },
                vsplit = 'v',
                split = 'x',
                tabe = 't',
                close = '<C-c>k',
                quit = 'q',
                shuttle = { '[w', 'p' },
                toggle_or_req = { 'u', '<TAB>' },
            },
        },
        implement = {
            enable = true,
            sign = true,
            lang = {},
            virtual_text = true,
            priority = 100,
        },
        beacon = {
            enable = false,
            frequency = 7,
        },
        floaterm = {
            height = 0.7,
            width = 0.7,
        },
    }
    require("lspsaga").setup(conf)
    -- require('lspsaga').config.outline.close_after_jump = true
end

return CONFIG
