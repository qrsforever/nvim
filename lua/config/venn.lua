-- https://github.com/jbyuki/venn.nvim

local CONFIG = {}

local hint = [[
^ Single^^^^^^ ^ Double^^^^^ ^ Heavy^^^^^^
^  ^ ^ _K_ ^ ^ ^  ^ ^ _W_ ^ ^ ^  ^ ^ _O_ ^ ^
^  _H_ ^ ^ _L_ ^  _A_ ^ ^ _D_ ^  _U_ ^ ^ _P_
^  ^ ^ _J_ ^ ^ ^  ^ ^ _S_ ^ ^ ^  ^ ^ _I_ ^ ^
^  ^^^^
^  Select region with <C-v> 
^  VBox  VBoxD  VBoxH 
^  VBoxO VBoxDO VBoxHO
^  _c_: space row col _Q_: quit
]]

function CONFIG.setup()
    require('hydra')({
        name = 'Draw Diagram',
        hint = hint,
        config = {
            color = 'pink',
            invoke_on_body = true,
            hint = {
                border = 'rounded',
                position = 'bottom-right'
            },
            on_enter = function()
                vim.o.virtualedit = 'all'
            end,
            on_exit = function()
            end,
        },
        mode = 'n',
        body = '<leader>dv',
        heads = {
            { 'H', '<C-v>h<ESC><CMD>VBox<CR>' },
            { 'J', '<C-v>j<ESC><CMD>VBox<CR>' },
            { 'K', '<C-v>k<ESC><CMD>VBox<CR>' },
            { 'L', '<C-v>l<ESC><CMD>VBox<CR>' },
            { 'A', '<C-v>h<ESC><CMD>VBoxD<CR>' },
            { 'S', '<C-v>j<ESC><CMD>VBoxD<CR>' },
            { 'W', '<C-v>k<ESC><CMD>VBoxD<CR>' },
            { 'D', '<C-v>l<ESC><CMD>VBoxD<CR>' },
            { 'U', '<C-v>h<ESC><CMD>VBoxH<CR>' },
            { 'I', '<C-v>j<ESC><CMD>VBoxH<CR>' },
            { 'O', '<C-v>k<ESC><CMD>VBoxH<CR>' },
            { 'P', '<C-v>l<ESC><CMD>VBoxH<CR>' },
            { 'c', '<CMD>lua custom_veen_canvas_spacer()<CR>' },
            -- { 'b', '<CMD>VBox<CR>', { mode = 'v' }},
            { 'Q', nil, { exit = true } },
        }
    })

    _G.custom_veen_canvas_spacer = function() -- {{{
        local inputs = vim.fn.split(vim.fn.input("how many rows and cols under the cursor(n[,m])? "), ',')
        if #inputs == 0 then
            vim.notify('input error')
            return
        end
        local rows, cols = tonumber(inputs[1]), vim.o.columns
        if #inputs > 1 then
            cols = tonumber(inputs[2])
        end
        local curpos, i, spaces = vim.fn.line('.'), 1, nil
        if cols < 100 then
            spaces = string.format('%-'.. cols ..'s', ' ')
        else
            spaces = string.format('%-99s', ' ')
            while i <= cols - 99
            do
                spaces = spaces .. ' '
                i = i + 1
            end
        end
        if curpos < vim.fn.line('$') then
            vim.cmd('norm! ' .. rows .. 'o')
        end
        i = 1
        while i <= rows
        do
            -- print(curpos + i,i, "[" .. spaces .. "]")
            vim.fn.setline(curpos + i, spaces)
            i = i + 1
        end
    end -- }}}

end

return CONFIG
