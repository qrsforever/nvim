local CONFIG = {}

function CONFIG.setup()
    local conf = {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
            "c", "cpp", "cuda", "go", "python", "make", "comment",
            "query", "yaml", "markdown", "markdown_inline",
            "lua", "bash", "vim", "sql",
            "html", "javascript",
        },
        sync_install = false,
        auto_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "java" },

        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,
            ---@diagnostic disable-next-line: unused-local
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = false,
            -- keymaps = {
            --     init_selection = "gnn", -- set to `false` to disable one of the mappings
            --     node_incremental = "grn",
            --     scope_incremental = "grc",
            --     node_decremental = "grm",
            -- },
        },
        indent = {
            enable = true
        }
    }
    require("nvim-treesitter.configs").setup(conf)
end

return CONFIG
