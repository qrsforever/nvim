local CONFIG = {}

function CONFIG.setup()
    local conf = {
        history = 360,
        enable_persistent_history = true,
        length_limit = 1024,
        continuous_sync = false,   -- if True, make dd,x (delete text op) slow
        db_path = _G.nvim_cache_path .. "/neoclip.sqlite3",
        filter = nil,
        preview = true,
        prompt = nil,
        default_register = { '+', '"', '*' }, -- TODO: cleared by nvim-tree copy-paste.lua TextYankPost {}
        default_register_macros = 'q',
        enable_macro_history = true,
        content_spec_column = true,
        disable_keycodes_parsing = false,
        on_select = {
            move_to_front = false,
            close_telescope = true,
        },
        on_paste = {
            set_reg = false,
            move_to_front = false,
            close_telescope = true,
        },
        on_replay = {
            set_reg = false,
            move_to_front = false,
            close_telescope = true,
        },
        on_custom_action = {
            close_telescope = true,
        },
        keys = {
            telescope = {
                i = {
                    select = '<cr>',
                    paste = '<c-p>',
                    paste_behind = nil,
                    replay = '<c-q>',  -- replay a macro
                    delete = '<c-d>',  -- delete an entry
                    edit = '<c-e>',  -- edit an entry
                    custom = {},
                },
                n = {
                    select = '<cr>',
                    paste = { 'p', '<c-p>' },
                    paste_behind = nil,
                    replay = '<c-q>',
                    delete = 'd',
                    edit = 'e',
                    custom = {},
                },
            },
            fzf = {
                select = 'default',
                paste = 'ctrl-p',
                paste_behind = 'ctrl-k',
                custom = {},
            },
        },
    }
    require('neoclip').setup(conf)
end

return CONFIG
