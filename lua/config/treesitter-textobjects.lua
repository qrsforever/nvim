-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

local CONFIG = {}

-- :TSTextobjectSelect @function.outer
function CONFIG.setup()
    local conf = {
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",

                    ["am"] = "@function.outer",
                    ["im"] = "@function.inner",

                    -- ["iC"] = "@call.inner",   -- use vab instead
                    -- ["aC"] = "@call.outer",

                    ["ie"] = "@block.inner",
                    ["ae"] = "@block.outer",

                    ["ao"] = "@loop.outer",
                    ["io"] = "@loop.inner",

                    ["id"] = "@conditional.inner",
                    ["ad"] = "@conditional.outer",

                    ["as"] = "@scope",
                },
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                include_surrounding_whitespace = true,
            },
            swap = {
                enable = false,
                swap_next = {
                    ["<C-N>"] = {query = {"@list_item", "@par.outer", "@section", "@parameter.inner"}}
                },
                swap_previous = {
                    ["<C-P>"] = {query = {"@list_item", "@par.outer", "@section", "@parameter.inner"}}
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                    ["]o"] = "@loop.outer",
                    ["]z"] = "@fold",
                    ["]d"] = "@conditional.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                    ["[o"] = "@loop.outer",
                    ["[z"] = "@fold",
                    ["[d"] = "@conditional.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
                -- goto_next = {
                --     ["]d"] = "@conditional.outer",
                -- },
                -- goto_previous = {
                --     ["[d"] = "@conditional.outer",
                -- }
            },
        },
    }
    require("nvim-treesitter.configs").setup(conf)
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
end

return CONFIG
