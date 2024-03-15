local CONFIG = {}

function CONFIG.setup()
    local util = require('utils')
    local conf = {
        options = {
            -- mode = "buffers",
            mode = "tabs",
            tab_size = 12,
            max_name_length = 18,
            name_formatter = function(buf)
                return util.basename_without_extension(buf.name)
            end,
            themable = true, -- allows highlight groups to be overriden
            diagnostics = false,  -- nvim_lsp, coc
            numbers = "ordinal",
            separator_style = "slope", -- "slant, padded_slant"
            show_tab_indicators = false,
            show_buffer_close_icons = false,
            show_close_icon = true,
            color_icons = false,
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            ---@diagnostic disable-next-line: unused-local
            custom_filter = function(buf_number, buf_numbers)
                -- true: will appear
                -- filter out filetypes you don't want to see
                ---@diagnostic disable-next-line: undefined-field
                if util.exists(_G.ignore_filetypes, vim.bo[buf_number].filetype) then
                    return false
                end
                return true
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    highlight = "BufferLineFill"
                },
                {
                    filetype = "OverseerList",
                    text = "Runner List",
                    text_align = "center",
                    highlight = "BufferLineFill"
                },
                {
                    filetype = "sagaoutline",
                    text = "Saga Outline",
                    text_align = "center",
                    highlight = "BufferLineFill"
                }
            },
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            }
        },
        highlights = {
            buffer_selected = {
                fg = "#0000ff",
                bold = true,
            },
            -- bufferline whole background
            -- fill = {
            --     bg = "#b3ccb6",
            --     fg = "#928374",
            -- },
            -- -- tab background
            -- background = {
            --     bg = "#b3ccb6",
            --     fg = "#928374",
            -- },
        },
    }

    require("bufferline").setup(conf)
end

return CONFIG
