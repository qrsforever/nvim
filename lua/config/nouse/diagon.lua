local CONFIG = {}

-- https://github.com/ArthurSonzogni/Diagon

function CONFIG.setup()
    -- sudo apt install diagon
    vim.g.diagon_use_echo = 1
    vim.keymap.set('n', '<leader>dd', ':Diagon<Space>', { desc = 'Diagon Prompt' })
    -- vim.keymap.set('n', '<leader>dm', ':Diagon Math<cr>', { desc = 'Diagon Math' })
    -- vim.keymap.set('n', '<leader>ds', ':Diagon Sequence<cr>', { desc = 'Diagon Sequence' })
    -- vim.keymap.set('n', '<leader>dt', ':Diagon Tree<cr>', { desc = 'Diagon Tree' })
end

return CONFIG
