vim.opt.runtimepath:remove(vim.fn.stdpath("config"))
vim.opt.packpath:remove(vim.fn.stdpath("data") .. "/site")
vim.opt.termguicolors = true
vim.opt.laststatus = 0

local test_dir = "/tmp/nvim-config"
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. "/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd("packadd packer.nvim")
	install_plugins = true
end

local packer = require("packer")

packer.init({
	package_root = test_dir .. "/pack",
	compile_path = test_dir .. "/plugin/packer_compiled.lua",
})


packer.startup(function(use)
	use("wbthomason/packer.nvim")

    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')

	if install_plugins then
		packer.sync()
	end
end)


local cmp = require'cmp'
cmp.setup({
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})


cmp.setup.cmdline({':', '@'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- nvim --clean -u mini.lua test.c
