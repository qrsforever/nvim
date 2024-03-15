-- https://github.com/chentoast/marks.nvim

local CONFIG = {}

function CONFIG.setup()
    local conf = {
        -- whether to map keybinds or not. default true
        default_mappings = false,
        -- which builtin marks to show. default {}
        -- builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = true,
        -- how often (in ms) to redraw signs/recompute mark positions. 
        -- higher values will have better performance but may cause visual lag, 
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        mappings = {}
    }
    require'marks'.setup(conf)
    _G.custom_place_upper_mark = function()
        uppermarks = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for i = 1, #uppermarks do
            local mark = uppermarks:sub(i, i)
            if vim.fn.line("'" .. mark) == 0
            then
                vim.cmd("normal! m" .. mark)
                break
            end
        end
    end
end

return CONFIG
