-- https://github.com/ggandor/leap.nvim

local CONFIG = {}

function CONFIG.setup()
    leap = require('leap')
    leap.opts.case_sensitive = false
    leap.opts.highlight_unlabeled_phase_one_targets = false
    leap.opts.max_highlighted_traversal_targets = 20
    -- leap.opts.special_keys = {
    --     next_target = '<enter>',
    --     prev_target = '<tab>',
    --     next_group = '<space>',
    --     prev_group = '<tab>',
    -- }

    vim.keymap.set({'n', 'x', 'o'}, ',f', '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, ',F', '<Plug>(leap-backward)')

    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = 'white', bold = true, nocombine = true })
    vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'black', bg = '#bfff19' })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#2e3440", bg = "#ebcb8b" })

    vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })
    -- vim.api.nvim_create_autocmd('User', {
    --     pattern = 'LeapEnter',
    --     command = 'set nocursorline',
    -- })
    -- vim.api.nvim_create_autocmd('User', {
    --     pattern = 'LeapLeave',
    --     command = 'set cursorline',
    -- })
end

return CONFIG
