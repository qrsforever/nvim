local CONFIG = {}

function CONFIG.setup()
    local conf = {
        autowidth = {
            enable = false,
            winwidth = 5,
            filetype = {
                help = 2,
            },
        },
        ignore = {
            buftype = { "quickfix" },
            filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
        },
        animation = {
            enable = true,
            duration = 300,
            fps = 30,
            easing = "in_out_sine"
        }
    }
    require("windows").setup(conf)
end

return CONFIG
