local CONFIG = {}

function CONFIG.setup()
    -- vim.diagnostic.config({ virtual_text = false, virtual_lines = { only_current_line = true } })
    vim.diagnostic.config({ virtual_lines = false })
    require("lsp_lines").setup()

    _G.custom_lsp_lines_toggle = function()
        local old_value = vim.diagnostic.config().virtual_lines
        if type(old_value) == 'table' then
            vim.diagnostic.config({ virtual_lines = false })
        else
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
        end
    end
end

return CONFIG
