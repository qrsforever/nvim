local CONFIG = {}

function CONFIG.setup()
    local conf = {
        undercurl = true,
        underline = false,
        bold = true,
        italic = {
            strings = false,
            comments = false,
            operators = false,
            folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = false, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {
            light0_hard = "#cce8cf",
            light4 = "#1060a0",
        },
        -- overrides = {
        --     SignColumn = { bg = "#cce8cf"}
        -- },
        dim_inactive = false,
        transparent_mode = false,
    }
    require("gruvbox").setup(conf)
end

return CONFIG
