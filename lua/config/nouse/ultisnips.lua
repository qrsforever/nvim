local CONFIG = {}

function CONFIG.setup()
    -- vim.cmd([[
        -- "[normal, horizontal, vertical, context]
        -- let g:UltiSnipsEditSplit = "horizontal"
        -- let g:UltiSnipsSnippetsDir = g:nvim_config_path . '/UltiSnips'
        -- let g:UltiSnipsSnippetDirectories =['UltiSnips']
        -- let g:UltiSnipsExpandTrigger="<c-h>"
        -- let g:UltiSnipsJumpBackwardTrigger="<c-j>"
        -- let g:UltiSnipsJumpForwardTrigger="<c-k>"
        -- let g:UltiSnipsListSnippets="<null>"
        -- let g:UltiSnipsUsePythonVersion = 3
    -- ]])
    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
    ---@diagnostic disable-next-line: undefined-field
    vim.g.UltiSnipsSnippetsDir = _G.nvim_config_path .. '/UltiSnips'
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
end

return CONFIG
