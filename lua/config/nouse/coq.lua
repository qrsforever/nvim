local CONFIG = {}

function CONFIG.setup()
    vim.g.coq_settings = {
        auto_start = 'shut-up',
        ['display.icons.mode'] = 'none',
        keymap = {
            jump_to_mark = '<C-L>',
            bigger_preview = '<C-g>',
        }
    }
end

return CONFIG
