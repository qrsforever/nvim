local CONFIG = {}

function CONFIG.setup()
    local icons = require("utils.icons")
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local util = require('lspconfig.util')

    -- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
    -- version: nvim-10
    local ok, wf = pcall(require, "vim.lsp._watchfiles")
    if ok then
        -- disable lsp watcher. Too slow on linux
        wf._watchfunc = function()
            return function() end
        end
    end

    local default_capabilities = cmp_lsp.default_capabilities()
    -- local lsp_status_ok, lsp_status = pcall(require, 'lsp-status')
    -- if lsp_status_ok then
    --     default_capabilities = cmp_lsp.default_capabilities(lsp_status.capabilities)
    -- end

    require("mason").setup {
        registries = {
            -- first do: rm ~/.local/share/nvim/mason/registries/github/mason-org/mason-registry
            -- @version: advoid auto update (need set http_proxy: nvim-proxy)
            -- "github:mason-org/mason-registry@2023-05-05-starry-lung",
            "github:mason-org/mason-registry",
        },
        ui = {
            icons = {
                package_installed = icons.lsp.server_installed,
                package_pending = icons.lsp.server_pending,
                package_uninstalled = icons.lsp.server_uninstalled,
            },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    }

    require("mason-lspconfig").setup {
        ensure_installed = {
            "clangd", -- clangd not support outgoing_calls: https://github.com/clangd/clangd/discussions/1206
            "cmake",
            "marksman",
            "yamlls",
            "pyright", -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
            -- "pylsp",   -- :PylspInstall plugins
            "lua_ls",
            "bashls",
            "vimls",
            "jsonls",
            -- "gopls",
            "dockerls",
            "docker_compose_language_service",
        },
        automatic_installation = false,
    }

    local servers = {
        clangd = {
            -- cmd = { "clangd" },
            filetypes = { 'c', 'cc', 'cpp', 'h', 'hpp', 'objc', 'objcpp', 'cuda', "cu", 'proto' }
        },
        cmake = {},
        pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_dir = function(fname)
                local root_files = {
                    'pyproject.toml',
                    'setup.py',
                    'setup.cfg',
                    'requirements.txt',
                    'Pipfile',
                    'pyrightconfig.json',
                }
                return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
            end,
            settings = {
                pyright = {
                    autoImportCompletion = true,
                },
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = false,
                        diagnosticMode = "workspace", -- workspace, openFilesOnly
                        typeCheckingMode = "off",
                    },
                },
                single_file_support = true,
            },
        },
        -- wait: https://github.com/python-lsp/python-lsp-server/issues/110
        -- pylsp = {
        --     root_dir = util.root_pattern(".git", ".venv", "_env", "setup.py"),
        --     settings = {
        --         pylsp = {
        --             configurationSources = {
        --                 -- 'black',
        --                 'flake8',
        --             },
        --             plugins = {
        --                 flake8 = {
        --                     enabled = true,
        --                     maxLineLength = 1000,
        --                 },
        --                 -- :PylspInstall python-lsp-ruff
        --                 ruff = {
        --                     enabled = false,
        --                     extendSelect = { "I" },
        --                 },
        --                 -- :PylspInstall python-lsp-black
        --                 black = {
        --                     enabled = false,
        --                     line_length = 88,
        --                 },
        --                 pylint = { enabled = false },
        --                 pyflakes = { enabled = false },
        --                 pycodestyle = { enabled = false },
        --                 autopep8 = { enabled = false }, -- covered by black
        --                 yapf = { enabled = false }, -- covered by black
        --             },
        --         },
        --     },
        --     single_file_support = true,
        -- },
        gopls = {},
        vimls = {},
        bashls = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            "vim", "describe", "it", "before_each", "after_each", "packer_plugins", "MiniTest"
                        },
                    },
                    workspace = { checkThirdParty = false, },
                    competion = { callSnippet = "Replace" },
                    telemetry = { enable = false },
                    hint = { enable = false, },
                },
            },
        },
        tsserver = {},
        jsonls = {},
        dockerls = {},
        docker_compose_language_service = {},
    }

    require("mason-lspconfig").setup_handlers {
        function(server_name)
            local opts = vim.tbl_deep_extend(
                "force",
                {
                    on_attach = function(client, bufnr)
                        -- if lsp_status_ok then
                        --     lsp_status.on_attach(client)
                        -- end
                        local caps = client.server_capabilities
                        -- dump(caps)
                        if caps.completionProvider then
                            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                        end
                        if caps.documentFormattingProvider then
                            vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
                        end
                        if caps.definitionProvider then
                            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                        end
                        -- require("config.mason.keymaps").setup(client, bufnr)
                    end,
                    capabilities = default_capabilities,
                    flags = { debounce_text_changes = 150 },
                },
                servers[server_name] or {}
            )
            lspconfig[server_name].setup(opts)
        end
    }

    -- vim.diagnostic.hide()
    -- vim.lsp.set_log_level("off")
    -- vim.lsp.set_log_level("debug")

end

return CONFIG
