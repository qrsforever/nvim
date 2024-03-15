-- https://github.com/anuvyklack/hydra.nvim
-- https://github.com/qrsforever/hydra.nvim

local CONFIG = {}

function CONFIG.setup()
    local Hydra = require('hydra')

    local fm_hint = [[
    Fast Move  ^ _<Esc>_ _q_^
    ^ ^ _k_ ^ ^    ^ ^ _K_ ^ ^
    _h_ ^ ^ _l_    _H_ ^ ^ _L_
    ^ ^ _j_ ^ ^    ^ ^ _J_ ^ ^
     10x      20x
    ]]

    Hydra({-- {{{
        name = 'Fast Move',
        hint = fm_hint,
        config = {
            color = 'pink',
            invoke_on_body = true, -- don't modify
            hint = {
                border = 'rounded',
                position = 'bottom-right'
            },
            on_enter = function()
            end,
            on_exit = function()
            end,
        },
        mode = 'n',
        body = '<leader>,m',
        heads = {
            { 'h', '10h',},
            { 'j', '10j' },
            { 'k', '10k' },
            { 'l', '10l' },
            { 'H', '20h' },
            { 'J', '20j' },
            { 'K', '20k' },
            { 'L', '20l' },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
        }
    })-- }}}

    local lw_hint = [[
           L Window
    _n_: next        _N_: next file
    _p_: previous    _P_: previous file
    _o_: toggleopen  _<Esc>_ _q_
    ]]

    Hydra({-- {{{
        name = 'L Window',
        hint = lw_hint,
        config = {
            color = 'pink',
            invoke_on_body = true, -- don't modify
            hint = {
                border = 'rounded',
                position = 'bottom-right'
            },
            on_enter = function()
                vim.o.cmdheight = 1
            end,
            on_exit = function()
            end,
        },
        mode = 'n',
        body = '[w',
        heads = {
            { 'n', '<cmd>Lnext<cr>' },
            { 'p', '<cmd>Lprev<cr>' },
            { 'N', '<cmd>lnfile<cr>' },
            { 'P', '<cmd>lpfile<cr>' },
            { 'o', '<cmd>lua require("utils.window").toggle_open_loclist()<cr>' },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
        }
    })-- }}}

    local cw_hint = [[
           C Window
    _n_: next        _N_: next file
    _p_: previous    _P_: previous file
    _o_: toggleopen  _<Esc>_ _q_
    ]]

    Hydra({-- {{{
        name = 'C Window',
        hint = cw_hint,
        config = {
            color = 'pink',
            invoke_on_body = true, -- don't modify
            hint = {
                border = 'rounded',
                position = 'bottom-right'
            },
            on_enter = function()
                vim.o.cmdheight = 1
            end,
            on_exit = function()
            end,
        },
        mode = 'n',
        body = ']w',
        heads = {
            { 'n', '<cmd>Cnext<cr>' },
            { 'p', '<cmd>Cprev<cr>' },
            { 'N', '<cmd>cnf<cr>' },
            { 'P', '<cmd>cpf<cr>' },
            { 'o', '<cmd>lua require("utils.window").toggle_open_qflist()<cr>' },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
        }
    })-- }}}

    local mc_hint = [[
          Mark Color _<Esc>_ _q_
    _n_: next        _N_: all next
    _p_: previous    _P_: all previous
    ]]

    Hydra({-- {{{
        name = 'Mark Color',
        hint = mc_hint,
        config = {
            color = 'pink',
            invoke_on_body = true, -- don't modify
            hint = {
                border = 'rounded',
                position = 'bottom-right'
            },
            on_enter = function()
            end,
            on_exit = function()
            end,
        },
        mode = 'n',
        body = '\\w',
        heads = {
            { 'n', '<cmd>normal \\n<cr>' },
            { 'p', '<cmd>normal \\p<cr>' },
            { 'N', '<cmd>normal \\N<cr>' },
            { 'P', '<cmd>normal \\P<cr>' },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
        }
    })-- }}}
end

return CONFIG
