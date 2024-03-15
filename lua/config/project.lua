local CONFIG = {}

function CONFIG.setup()
    local conf = {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = true,  -- if false will affect nvim-tree display

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        -- detection_methods = { "lsp", "pattern" },
        detection_methods = { "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", ".hg", ".bzr", ".svn" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},
        exclude_dirs = { "~/.local/*" },

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = false,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'win',

        -- Path where project.nvim will store the project history for use in telescope
        datapath = _G.nvim_cache_path,
    }
    require("project_nvim").setup(conf)

    local util = require('utils')
    _G.custom_bookmark_add_project = function()
        local path = vim.fn.expand("%:p:h")
        local wsdir = util.wsdir(path)
        if util.is_empty(wsdir)
        then
            -- AddProject
            require("project_nvim.project").add_project_manually()
            util.info('Add any project: ' .. path)
        else
            -- ProjectRoot
            require("project_nvim.project").on_buf_enter()
            util.info('Add git project: ' .. wsdir)
        end
    end
end

return CONFIG
