local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'bookmarks')

function CONFIG.setup()
    -- input use: mytag:mydescription
    -- window move: <c-j> and <c-k>
    local conf = {
        storage_dir = _G.nvim_cache_path .. "/bookmarks",
        mappings_enabled = false, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
        keymap = {
            toggle = "<tab><tab>", -- Toggle bookmarks(global keymap)
            add = "\\z", -- Add bookmarks(global keymap)
            jump = "<CR>", -- Jump from bookmarks(buf keymap)
            delete = "dd", -- Delete bookmarks(buf keymap)
            order = "<space><space>", -- Order bookmarks by frequency or updated_time(buf keymap)
            delete_on_virt = "\\dd", -- Delete bookmark at virt text line(global keymap)
            show_desc = "\\sd", -- show bookmark desc(global keymap)
        },
        width = 0.8, -- Bookmarks window width:  (0, 1]
        height = 0.6, -- Bookmarks window height: (0, 1]
        preview_ratio = 0.4, -- Bookmarks preview window ratio (0, 1]
        preview_ext_enable = false, -- If true, preview buf will add file ext, preview window may be highlighed(treesitter), but may be slower.
        fix_enable = false, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.

        virt_text = "🔖", -- Show virt text at the end of bookmarked lines
        virt_pattern = { "*.py", "*.c", "*.cpp", "*.cc", "*.go", "*.lua", "*.sh", "*.h", "*.hpp" }, -- Show virt text only on matched pattern
        border_style = "single", -- border style: "single", "double", "rounded" 
        hl = {
            border = "TelescopeBorder", -- border highlight
            cursorline = "guibg=Gray guifg=White", -- cursorline highlight
        }
    }
    require("bookmarks").setup(conf)
end

return CONFIG
