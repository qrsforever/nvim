local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'Trouble')

function CONFIG.setup()
    local conf = {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 20, -- height of the trouble list when position is top or bottom
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"o", "<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            open_split = { "x" }, -- open buffer in new split
            open_vsplit = { "v" }, -- open buffer in new vsplit
            open_tab = { "t" }, -- open buffer in new tab
            jump_close = {"O"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "p", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "P", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- previous item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = true, -- automatically fold a file trouble list at creation
        auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
    require("trouble").setup(conf)
end

return CONFIG
