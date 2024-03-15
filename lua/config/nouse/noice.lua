-- https://github.com/folke/noice.nvim

local CONFIG = {}

table.insert(_G.ignore_filetypes, 'noice')

function CONFIG.setup()
    local conf = {
        messages = { view_search = false },
        health = { checker = false },
        lsp = {
            progress = {
                enabled = true,
                -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                -- See the section on formatting for more details on how to customize.
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            message = {
                -- Messages shown by lsp servers
                enabled = false,
                view = "notify",
                opts = {},
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- cmdline_popup or cmdline
        },
        views = {
            split = { enter = true },
            mini = { win_options = { winblend = 100 } },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "E486" },
                        { find = "E433" },  -- no tags file
                        { find = "written" },
                        { find = "Conflict %[%d+" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = '%d lines yanked' },
                    },
                },
                view = "mini",
            },
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "Done!" },  -- LeaderF
                        { find = "%d+L, %d+B" },
                        { find = '%d fewer lines' },
                        { find = '%d more lines' },
                        { kind = "search_count" }
                    },
                },
                skip = true,
            },
            { filter = { event = "emsg", find = "E23" }, skip = true },
            { filter = { event = "emsg", find = "E20" }, skip = true },
        },
    }
    require("noice").setup(conf)
end

return CONFIG

--        use({
--            "folke/noice.nvim",
--            requires = {
--                "MunifTanjim/nui.nvim",
--                "rcarriga/nvim-notify",
--            },
--            config = function() require("config.noice").setup() end,
--            disable = true,
--        })
