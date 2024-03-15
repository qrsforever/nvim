local UTIL = {}

local Terminal = require("toggleterm.terminal").Terminal

local function default_on_open(term)
  vim.cmd "stopinsert"
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

function UTIL.open_term(cmd, opts)
    opts = opts or {}
    opts.size = opts.size or vim.o.columns * 0.5
    opts.direction = opts.direction or "vertical"
    opts.on_open = opts.on_open or default_on_open
    opts.on_exit = opts.on_exit or nil

    local new_term = Terminal:new {
        cmd = cmd,
        dir = "git_dir",
        auto_scroll = false,
        autochdir = true,
        close_on_exit = false,
        start_in_insert = false,
        on_open = opts.on_open,
        on_exit = opts.on_exit,
    }
    new_term:open(opts.size, opts.direction)
end

return UTIL
