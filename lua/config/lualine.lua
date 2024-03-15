local CONFIG = {}

function CONFIG.setup()
    local venv_select_ok, venv_select =  pcall(require, 'venv-selector')
    local saga_symbol = require("lspsaga.symbol.winbar")

    local powerline = require'lualine.themes.powerline'
    powerline.insert.c =  { fg = '#d2b392', bg = '#3c3836' }

	local conf = {
        options = {
            icons_enabled = false,
            theme = powerline,
            -- component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            component_separators = { left = '', right = '' },
            -- section_separators = { left = '', right = '' },
            disabled_filetypes = {
                'packer', 'alpha',
                statusline = {},
                winbar = {},
            },
            ignore_focus = _G.ignore_filetypes,
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 2000,
            }
        },
        extensions = { 'quickfix', 'overseer', 'man', 'mason' },
        sections = {
            lualine_a = {
                'mode',
                -- {
                --     function()
                --         if vim.api.nvim_get_vvar("hlsearch") == 1 then
                --             local res = vim.fn.searchcount({maxcount = 200, timeout = 500})
                --             if res.total > 0 then
                --                 return string.format("%d/%d", res.current, res.total)
                --             end
                --         end
                --         return ""
                --     end,
                --     type = "lua_expr",
                -- },
                {
                    function ()
                        if venv_select_ok then
                            local venv = venv_select.get_active_venv()
                            if venv then
                                local venv_parts = vim.fn.split(venv, "/")
                                local venv_name = venv_parts[#venv_parts]
                                return 'ṽ ' .. venv_name
                            end
                        end
                        local venv_name = vim.env.VIRTUAL_ENV_PROMPT
                        if venv_name then
                            return 'ṽ ' .. string.sub(venv_name, 2, string.len(venv_name) - 2)
                        else
                            return ''
                        end
                    end,
                },
            },
            -- lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_b = {
                {
                    "filename",
                    path = false,
                    symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
                },
            },
            lualine_c = {
                {
                    function()
                        local bar = saga_symbol.get_bar()
                        if bar then
                            return ' ' .. bar:gsub("#Saga", "#NoSaga") -- remove Saga color
                        end
                        return ''
                    end,
                    -- color = { fg = "cyan" }, padding = { left = 0 , right = 0 },
                }
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = {
                'location',
                -- { 'overseer' },
                {
                    function()
                        return _G.sys_hostname
                    end,
                },
            }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {
                {
                    "filename",
                    path = false,
                    symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
                },
            },
            lualine_c = {},
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
    }
    require("lualine").setup(conf)
end

return CONFIG
