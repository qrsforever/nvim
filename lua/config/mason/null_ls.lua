local CONFIG = {}

function CONFIG.setup()
    local null_ls = require("null-ls")
    local icons = require("utils.icons")
    local conf = {
        automatic_setup = true,
        ensure_installed = {
            "stylua",
            "jq",
            "black",
            "clang-format",
        },
        automatic_installation = false,
    }

    null_ls.setup({
        sources = {
            -- Anything not supported by mason
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.formatting.black.with { extra_args = { "--fast", "--line-length=120" } },
            -- null_ls.builtins.diagnostics.flake8.with({
            --     prefer_local = ".venv/bin",
            -- }),
        },
       debug = false,
    })
    require("mason-null-ls").setup(conf)

    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Info },
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    local diagnostic = {
        virtual_text = false,
        -- virtual_text = { spacing = 4, prefix = "●" },
        -- virtual_text = {
        --     severity = {
        --         min = vim.diagnostic.severity.ERROR,
        --     },
        -- },
        signs = { active = signs },
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }
    vim.diagnostic.config(diagnostic)
    -- local float = { focusable = true, style = "minimal", border = "rounded" }
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

return CONFIG
