-- https://github.com/L3MON4D3/LuaSnip

local CONFIG = {}

function CONFIG.setup()
    -- vim.cmd([[
    --     let g:snips_author = "erlangai"
    --     let g:snips_email = "erlangai@gmail.com"
    --     let g:snips_github = "https://github.com/qrsforever"
    -- ]])

    -- rafamadriz/friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- honza/vim-snippets
    require("luasnip.loaders.from_snipmate").lazy_load()
end

return CONFIG
