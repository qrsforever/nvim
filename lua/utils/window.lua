local UTIL = {}

function UTIL.toggle_open_loclist(split_pos, height)
    local openpos = split_pos or 'rightbelow'
    local wheight = height or '15'
    local win = vim.api.nvim_get_current_win()
    local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
    local action = qf_winid > 0 and ' lclose' or ' lopen ' .. wheight
    vim.cmd('silent! ' .. openpos .. action)
end

function UTIL.toggle_open_qflist(split_pos, height)
    local openpos = split_pos or 'rightbelow'
    local wheight = height or '15'
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and ' cclose' or ' cwindow ' .. wheight
    vim.cmd('silent! ' .. openpos .. action)
end

return UTIL
