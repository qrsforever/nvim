local CONFIG = {}

function CONFIG.setup()
    local conf = {
        show_diagnostic_number = false,
        show_diagnostic_source = false,
    }
    require("echo-diagnostics").setup(conf)
    vim.cmd("autocmd CursorHold * lua require('echo-diagnostics').echo_line_diagnostic()")
end

return CONFIG
