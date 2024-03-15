local CONFIG = {}

function CONFIG.setup()
    local conf = {
        -- automatic_setup = false,
        ensure_installed = {
            -- "python",
            "delve"
        },
        automatic_installation = false,
        handlers = {
            function(config)
                require('mason-nvim-dap').default_setup(config)
            end,
            python = function(config)
                config.adapters = {
                    type = "executable",
                    command = "python3",
                    args = {
                        "-m",
                        "debugpy.adapter",
                    },
                }
                require('mason-nvim-dap').default_setup(config)
            end,
        },
    }
    require("mason-nvim-dap").setup(conf)
end

return CONFIG
