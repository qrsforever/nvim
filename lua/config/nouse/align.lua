local CONFIG = {}

function CONFIG.setup()
    local NS = { noremap = true, silent = true }

    -- v maps to both visual and select mode. x: only visual mode
    -- Aligns to 1 character
    vim.keymap.set(
        'v',
        'aa',
        function()
            require'align'.align_to_char({
                length = 1,
            })
        end,
        NS
    )

    -- Aligns to 2 characters with previews
    vim.keymap.set(
        'x',
        'ad',
        function()
            require'align'.align_to_char({
                preview = true,
                length = 2,
            })
        end,
        NS
    )

    -- Aligns to a string with previews
    vim.keymap.set(
        'x',
        'aw',
        function()
            require'align'.align_to_string({
                preview = true,
                regex = false,
            })
        end,
        NS
    )

    -- Aligns to a Vim regex with previews
    vim.keymap.set(
        'x',
        'ar',
        function()
            require'align'.align_to_string({
                preview = true,
                regex = true,
            })
        end,
        NS
    )
end
return CONFIG
