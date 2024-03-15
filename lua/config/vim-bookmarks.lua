local CONFIG = {}

_G._bookmarks_loaded = 0

function CONFIG.setup()
    -- MattesGroeger/vim-bookmarks
    if _G._bookmarks_loaded == 0 then
        vim.cmd([[
            let g:bookmark_no_default_key_mappings = 1
            let g:bookmark_save_per_working_dir = 0
            let g:bookmark_manage_per_buffer = 0
            let g:bookmark_auto_save = 1
            let g:bookmark_highlight_lines = 1
            let g:bookmark_show_warning = 1
            let g:bookmark_show_toggle_warning = 0
            let g:bookmark_center = 0
            let g:bookmark_auto_close = 1
            let g:bookmark_location_list = 0
            let g:bookmark_disable_ctrlp = 1
            let g:bookmark_auto_save_file = g:nvim_cache_path . '/vim-bookmarks'
        ]])
    end
    _G._bookmarks_loaded = 1
    _G.custom_telescope_bookmarks = function()
        local width = math.floor(0.95 * vim.o.columns)
        local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions
        require('telescope').extensions.vim_bookmarks.all {
            prompt_title = "Bookarks",
            initial_mode = "normal",
            layout_strategy = "vertical",
            layout_config = { width = width, height = 0.95 },
            width_line = 5, width_anno = 25, width_name = 25, width_path = width - 30,
            attach_mappings = function(_, map)
                map('n', 'dd', bookmark_actions.delete_selected_or_at_cursor)
                return true
            end
        }
    end
end

return CONFIG
