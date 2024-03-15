local CONFIG = {}

-- @diagnostic disable-next-line: undefined-field
-- table.insert(_G.ignore_filetypes, 'Outline')

function CONFIG.setup()
    local icons = require('utils.icons').symbols
    local conf = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = 'right',
		relative_width = true,
		width = 22,
		auto_close = false,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = false,
		preview_bg_highlight = 'Pmenu',
		autofold_depth = 1,
		auto_unfold_hover = true,
		fold_markers = { '', '' },
		wrap = false,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {"<esc>", "q"},
            goto_location = {"<cr>", "<2-LeftMouse>"},
            focus_location = "o",
            hover_symbol = "v",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "h",
            unfold = "l",
            fold_all = "W",
            unfold_all = "E",
            fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {'Module', 'Field', 'Variable', ''},
        symbols = {
            File = { icon = icons.File, hl = "@text.uri" },
            Module = { icon = icons.Module, hl = "@namespace" },
            Namespace = { icon = icons.Namespace, hl = "@namespace" },
            Package = { icon = icons.Namespace, hl = "@namespace" },
            Class = { icon = icons.Class, hl = "@type" },
            Method = { icon = icons.Method, hl = "@method" },
            Property = { icon = icons.Property, hl = "@method" },
            Field = { icon = icons.Field, hl = "@field" },
            Constructor = { icon = icons.Constructor, hl = "@constructor" },
            Enum = { icon = icons.Enum, hl = "@type" },
            Interface = { icon = icons.Interface, hl = "@type" },
            Function = { icon = icons.Function, hl = "@function" },
            Variable = { icon = icons.Variable, hl = "@constant" },
            Constant = { icon = icons.Constant, hl = "@constant" },
            String = { icon = icons.String, hl = "@string" },
            Number = { icon = icons.Number, hl = "@number" },
            Boolean = { icon = icons.Boolean, hl = "@boolean" },
            Array = { icon = icons.Array, hl = "@constant" },
            Object = { icon = icons.Object, hl = "@type" },
            Key = { icon = icons.Key, hl = "@type" },
            Null = { icon = icons.Null, hl = "@type" },
            EnumMember = { icon = icons.EnumMember, hl = "@field" },
            Struct = { icon = icons.Struct, hl = "@type" },
            Event = { icon = icons.Event, hl = "@type" },
            Operator = { icon = icons.Operator, hl = "@operator" },
            TypeParameter = { icon = icons.TypeParameter, hl = "@parameter" },
            Component = { icon = icons.Component, hl = "@function" },
            Fragment = { icon = icons.Fragment, hl = "@constant" },
        },
    }

    require("symbols-outline").setup(conf)
end

return CONFIG
