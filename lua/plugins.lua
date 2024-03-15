---@diagnostic disable: different-requires
local BALL = {}

function BALL.setup(flag)
	-- print("ball setup", vim.fn.stdpath("data"))
    local util = require("utils")
	local packer_bootstrap = false
    local nvim_config_path = util.nvim_config_path()

    local DISENABLE = flag

    -- 安装插件管理器
	local function packer_init()
        local install_path = nvim_config_path .. "/pack/packer/start/packer.nvim"
        if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
            print("download packer.nvim...")
			packer_bootstrap = vim.fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			}
			vim.cmd [[packadd packer.nvim]]
		end
		-- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
	end

	-- packer config
	local conf = {
        profile = {
            enable = true,
            threshold = 0,
        },
		display ={
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
        -- snapshot_path = nvim_config_path .. "/.cache/packer.nvim",
        package_root = nvim_config_path .. "/pack",
        compile_path = nvim_config_path .. "/plugin/packer_compiled.lua",
	}

    -- 安装及插件管理
    local function plugins(use)

        use { "wbthomason/packer.nvim" }

        use {
            "ellisonleao/gruvbox.nvim",
            config = function()
                require("config.gruvbox").setup()
                vim.cmd([[
                    if has("termguicolors")
                        set termguicolors
                    endif
                    set background=light
                    colorscheme gruvbox
                ]])
            end,
            disable = false,
        }

		use {
			"folke/which-key.nvim",
			event = "VimEnter",
			module = { "which-key" },
            config = function() require("config.which-key").setup() end,
			disable = false,
		}

		use {
			"nvim-tree/nvim-tree.lua",
            requires = { "nvim-tree/nvim-web-devicons" },
            config = function() require("config.nvim-tree").setup() end,
            disable = DISENABLE,
        }

        use {
            -- "ahmedkhalf/project.nvim",
            "qrsforever/project.nvim",
            config = function() require("config.project").setup() end,
            disable = DISENABLE,
        }

        use {
            "akinsho/bufferline.nvim",
            requires = { "nvim-tree/nvim-web-devicons" },
            config = function() require("config.bufferline").setup() end,
            disable = DISENABLE,
        }

        use {
            "numToStr/Comment.nvim",
            config = function() require("config.Comment").setup() end,
            disable = DISENABLE,
        }

        use {
            "phaazon/hop.nvim",
            config = function() require("config.hop").setup() end,
            disable = DISENABLE,
        }

        use {
            'ggandor/leap.nvim',
            requires = 'tpope/vim-repeat',
            config = function() require("config.leap").setup() end,
            disable = DISENABLE,
        }

        use {
            "anuvyklack/windows.nvim",
            requires = { "anuvyklack/middleclass" },
            config = function() require("config.windows").setup() end,
            disable = DISENABLE,
        }

        use {
            "TimUntersberger/neogit",
            requires = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
            },
            config = function() require("config.neogit").setup() end,
            disable = DISENABLE,
        }

        -- code completion
        use {
            "hrsh7th/nvim-cmp",
            config = function() require("config.cmp").setup() end,
            requires = {
                { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
                { "hrsh7th/cmp-nvim-lsp-signature-help" },
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-path" },
                { "hrsh7th/cmp-cmdline" },
                { "hrsh7th/cmp-nvim-lua" },
                -- { "quangnguyen30192/cmp-nvim-ultisnips" },
                -- {
                --     "SirVer/ultisnips",
                --     requires = {{'honza/vim-snippets', rtp = '.'}},
                --     config = function() require("config.ultisnips").setup() end,
                --     disable = DISENABLE
                -- },
                "rafamadriz/friendly-snippets",
                "honza/vim-snippets",
            },
            disable = DISENABLE,
        }
        use { 'saadparwaiz1/cmp_luasnip' }
        use {
            'L3MON4D3/LuaSnip',
            -- after = 'nvim-cmp',
            wants = { "friendly-snippets", "vim-snippets" },
            config = function() require("config.luasnip").setup() end,
            disable = DISENABLE
        }

        -- mason: lsp dap linters formatters
		use {
            "williamboman/mason-lspconfig.nvim",
            requires = {
                { "neovim/nvim-lspconfig" },
                { "williamboman/mason.nvim", run = ":MasonUpdate" },
                { "WhoIsSethDaniel/mason-tool-installer.nvim", disable = true }
            },
            config = function() require("config.mason.lsp").setup() end,
            disable = DISENABLE,
        }

        use {
            "jay-babu/mason-null-ls.nvim",
            event = { "BufReadPre", "BufNewFile" },
            requires = {
                "williamboman/mason.nvim",
                "jose-elias-alvarez/null-ls.nvim",
            },
            config = function() require("config.mason.null_ls").setup() end,
            disable = DISENABLE,
        }

        use({
            "glepnir/lspsaga.nvim",
            -- branch = "main",
            after = "nvim-lspconfig",
            config = function() require("config.lspsaga").setup() end,
            requires = {
                {"nvim-tree/nvim-web-devicons"},
                --Please make sure you install markdown and markdown_inline parser
                {"nvim-treesitter/nvim-treesitter", disable=DISENABLE}
            },
            disable = DISENABLE,
        })

        -- search
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/plenary.nvim"},
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                { "nvim-telescope/telescope-project.nvim" },
                {
                    -- TODO make key dd, x (delete text op) slowly ?
                    "AckslD/nvim-neoclip.lua",
                    requires = { "kkharji/sqlite.lua" },
                    config = function()
                        require("config.neoclip").setup()
                        require('telescope').load_extension('neoclip')
                        require('telescope').load_extension('macroscope')
                    end,
                    disable = false
                },
                {
                    "qrsforever/telescope-vim-bookmarks.nvim",
                    requires = {
                        "MattesGroeger/vim-bookmarks",
                        config = function()
                            require("config.vim-bookmarks").setup()
                            require('telescope').load_extension('vim_bookmarks')
                        end,
                        disable = false
                    }
                },
                {
                    "qrsforever/telescope-ntree-marks.nvim",
                    config = function()
                        require('telescope').load_extension('ntree_marks')
                    end,
                }

            },
            config = function() require("config.telescope").setup() end,
            disable = DISENABLE,
        }

		use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function() require("config.treesitter").setup() end,
            disable = DISENABLE,
        }

        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function() require("config.treesitter-textobjects").setup() end,
            disable = DISENABLE,
        })

        use {
            "chentoast/marks.nvim",
            config = function() require("config.marks").setup() end,
            disable = DISENABLE,
        }

        -- map hint (vim.o.eventignore影响lsp补全)
        use({
            'qrsforever/hydra.nvim', -- 'anuvyklack/hydra.nvim',
            config = function() require("config.hydra").setup() end,
            disable = DISENABLE,
        })

        -- drawit
        use({
            "jbyuki/venn.nvim",
            config = function() require("config.venn").setup() end,
            disable = DISENABLE,
        })

        -- use nvim-proxy to download release bin
        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
            config = function() require("config.markdown").setup() end,
            disable = DISENABLE,
        })

        -- Vim Scripts
		use({
            "Yggdroot/LeaderF",
            run = ":LeaderfInstallCExtension",
            config = function() require("config.LeaderF").setup() end,
            disable = DISENABLE,
        })

        use({
            "vim-scripts/vcscommand.vim",
            config = function() require("config.vcscommand").setup() end,
            disable = DISENABLE,
        })

        use({
            "voldikss/vim-translator",
            config = function() require("config.translator").setup() end,
            disable = DISENABLE,
        })

        use({
            'echasnovski/mini.align',
            config = function() require("config.mini_align").setup() end,
            disable = DISENABLE,
        })

        use({
            "qrsforever/vim-sync",
            requires = { "skywind3000/asyncrun.vim" },
            config = function() require("config.vim-sync").setup() end,
            disable = DISENABLE,
        })

        use({
            "rcarriga/nvim-notify",
            config = function() require("config.notify").setup() end,
            disable = DISENABLE,
        })

        use({
            "stevearc/overseer.nvim",
            config = function() require("config.overseer").setup() end,
            disable = DISENABLE,
        })

		use {
			"nvim-lualine/lualine.nvim",
            after = 'lspsaga.nvim',
            config = function() require("config.lualine").setup() end,
            disable = DISENABLE,
		}

        use {
            "Vigemus/iron.nvim",
            config = function() require("config.iron").setup() end,
            disable = DISENABLE,
        }

        if packer_bootstrap then
            print("Restart Neovim required after installation!")
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require("packer")
    packer.init(conf)
    packer.startup(plugins)
end

return BALL
