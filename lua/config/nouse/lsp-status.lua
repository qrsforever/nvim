local CONFIG = {}

function CONFIG.setup()
    local lsp_status = require('lsp-status')
    lsp_status.config({
        current_function = true,
        show_filename = false,
        diagnostics = false,
        update_interval = 500,
        status_symbol = '𝓕',
        -- indicator_separator = '',
        -- component_separator = '',
    })
    lsp_status.register_progress()
end

return CONFIG

--        use {
--            "nvim-lua/lsp-status.nvim",
--            config = function() require("config.lsp-status").setup() end,
--            disable = DISENABLE
--        }
