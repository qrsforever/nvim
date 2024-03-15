local CONFIG = {}

-- sudo apt install fd-find

function CONFIG.setup()
    local cache_dir = require("utils").nvim_cache_path() .. '/venv-selector/'
    local conf = {
        search = true,
        name = "venv",
        search_workspace = true,
        search_venv_managers = true,
        parents = 2, -- When search is true, go this many directories up from the current opened buffer
        auto_refresh = false, -- Uses cached results from last search
        cache_file = cache_dir .. "venvs.json",
        cache_dir = cache_dir,
        enable_debug_output = false,
    }
    require("venv-selector").setup(conf)
end

return CONFIG
