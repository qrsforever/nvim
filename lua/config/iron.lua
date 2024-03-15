-- https://github.com/Vigemus/iron.nvim

local CONFIG = {}

-- ipython keyboard shortcuts: https://ipython.readthedocs.io/en/stable/config/shortcuts/index.html
-- ctrl + e: Apply autosuggestion or jump to end of line.
-- ctrl + i / tab: Key binding handler for readline-style tab completion.

function CONFIG.setup()
    local conf = {
        config = {
            memory_management = 'singleton',
            -- Toggling behavior is on by default.
            -- Other options are: `single` and `focus`
            visibility = require("iron.visibility").toggle,
            -- Whether a repl should be discarded or not
            scratch_repl = true,
            -- Your repl definitions come here
            repl_definition = {
                python = require("iron.fts.python").ipython
            },
            -- How the repl window will be displayed
            -- See below for more information
            -- repl_open_cmd = require('iron.view').bottom(40),
            -- repl_open_cmd = require('iron.view').center("30%", 50),
            repl_open_cmd = require('iron.view').split.vertical.botright(0.42)
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
            send_motion = ",js",  -- insert <O-PENDING>, then exec motion: ap (a paragrah) am(a function) aw(a word)
            visual_send = ",js",
            send_file = ",jf",
            send_line = ",jl",
            send_until_cursor = ",ju",
            cr = ",j<cr>",
            interrupt = ",jx",
            exit = ",jQ",
            clear = ",jC",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
            italic = false
        },
        ignore_blank_lines = true,
    }
    require("iron.core").setup(conf)

    _G.custom_iron_clear = function()
        local ft = vim.bo.filetype
        if ft == '' then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i<cr>clear<cr>', true, false, true), "n", true)
        elseif ft == "python" then
            vim.cmd(":IronSend clear")
        end
    end

    _G.custom_iron_quit = function()
        local ft = vim.bo.filetype
        if ft == '' then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i<cr>quit<cr>', true, false, true), "n", true)
        elseif ft == "python" then
            vim.cmd(":IronSend quit")
        end
    end

    vim.cmd([[
        noremap ,jt ,jsit  " a inner tag eg: <cell> </cell>
        noremap ,jm ,jsam  " a around function
        noremap ,jp ,jsap  " a around paragrah
    ]])
end

return CONFIG
