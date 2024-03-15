local CONFIG = {}

function CONFIG.setup()
    local cmp = require("cmp")
    -- local lsp = require("lspconfig")
    local icons = require("utils.icons").symbols
    local cmp_kinds = {
        Text = icons.Text,
        Method = icons.Method,
        Function = icons.Function,
        Constructor = icons.Constructor,
        Field = icons.Field,
        Variable = icons.Variable,
        Class = icons.Class,
        Interface = icons.Interface,
        Module = icons.Module,
        Property = icons.Property,
        Unit = icons.Unit,
        Value = icons.Value,
        Enum = icons.Enum,
        Keyword = icons.Keyword,
        Snippet = icons.Snippet,
        Color = icons.Color,
        File = icons.File,
        Reference = icons.Reference,
        Folder = icons.Folder,
        EnumMember = icons.EnumMember,
        Constant = icons.Constant,
        Struct = icons.Struct,
        Event = icons.Event,
        Operator = icons.Operator,
        TypeParameter = icons.TypeParameter
    }

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require "luasnip"
    local conf = {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp", group_index = 1, keyword_length = 2, trigger_characters={".", "->"} },
            { name = "nvim_lsp_signature_help" },
            { name = "buffer", group_index = 2, keyword_length = 3, max_item_count = 10 },
            { name = "path" },
            { name = "luasnip" },
        },
        formatting = {
            fields = { "menu", "abbr", "kind" },
            format = function(entry, vim_item)
                vim_item.kind = cmp_kinds[vim_item.kind] or ""
                vim_item.menu = ({
                    nvim_lsp = "🅻",
                    buffer = "🅱",
                    path = "🅿",
                    luasnip = "🆂",
                    nvim_lua = "🅰",
                })[entry.source.name]
                return vim_item
            end,
        },
        completion = {
            completeopt = "menu,menuone,noselect",
            keyword_length = 2,
            -- col_offset = -3,
            side_padding = 2,
        },
		mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s", "c", }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", "c", }),
			['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i', 'c'}),
			['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i', 'c'}),
			['<C-n>'] = cmp.mapping({
				c = function()
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					else
						vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
					end
				end,
				i = function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					else
						fallback()
					end
				end
			}),
			['<C-p>'] = cmp.mapping({
				c = function()
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					else
						vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
					end
				end,
				i = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					else
						fallback()
					end
				end
			}),
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
			['<C-g>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
			['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
			['<CR>'] = cmp.mapping({
				i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
				-- c = function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
				-- 	else
				-- 		fallback()
				-- 	end
				-- end
			}),
            ["<C-l>"] = cmp.mapping {
                i = function(fallback)
                    if luasnip.choice_active() then
                        luasnip.change_choice(1)
                    else
                        fallback()
                    end
                end,
            },
            ["<C-u>"] = cmp.mapping {
                i = function(fallback)
                    if luasnip.choice_active() then
                        require "luasnip.extras.select_choice"()
                    else
                        fallback()
                    end
                end,
            },
            ["<C-j>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s", "c", }),
            ["<C-k>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", "c", }),
        },
        view = { },
        window = {
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
            },
        },
    }
    cmp.setup(conf)

    -- :h getcmdtype(), @ for vim.fn.input()
    cmp.setup.cmdline({ '/', '?' }, {
        view = { entries = {name = 'wildmenu', separator = '|' } },
        -- https://github.com/hrsh7th/nvim-cmp/issues/1566
        completion = { autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged } },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
    -- filetype c: https://github.com/hrsh7th/nvim-cmp/issues/1612
    cmp.setup.cmdline({':', '@'}, {
        -- view = { entries = {name = 'custom', selection_order = 'near_cursor' } },
        completion = { autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged } },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }    -- group_index = 1
        }, {
            { name = 'cmdline' } -- group_index = 2
        })
    })

    cmp.setup.filetype(
        { "python", "lua", "vim" },
        {
            sources = cmp.config.sources({
               -- python for ( trigger is not good, so use ctl + g manually trigger
                { name = "nvim_lsp", group_index = 1, keyword_length = 1, trigger_characters={"."} },
                { name = "nvim_lsp_signature_help" },
                { name = "buffer", group_index = 2, keyword_length = 3, max_item_count = 10 },
                { name = "path" },
                { name = "luasnip" },
                { name = "nvim_lua" },
            }),
       --      mapping = {
	   --          ['<C-g>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
       --          ['<C-e>'] = cmp.mapping.abort(),
       --      },
        }
    )

    vim.cmd([[
        augroup NvimCmp
            au!
            au FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
        augroup END
    ]])
end

return CONFIG
