---@diagnostic disable: undefined-field
local CONFIG = {}

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'NvimTree')

function CONFIG.setup()
    local util = require('utils')
    local conf = {
        respect_buf_cwd = false,
        sync_root_with_cwd = false,
        auto_reload_on_write = false,
        reload_on_bufenter = false,

		sort_by = "name",
        disable_netrw = true,
		hijack_cursor = false,
		hijack_netrw = false,
		hijack_unnamed_buffer_when_opening = false,

        view = {
            adaptive_size = false,
            centralize_selection = false,
            number = true,
            relativenumber = true,
            width = _G.left_siderbar_width,
            side = "left",
        },
        renderer = {
            full_name = false,
            highlight_opened_files = "icon",
            highlight_modified = "none",
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            root_folder_label = function(path)
                -- path truncate like nerdtree.vim
                local p = vim.fn.fnamemodify(path, ":p:~")
                local limit = 25 -- set limit view.width - 5 (sign number)
                local psize = string.len(p)
                if psize > limit then
                    local names = util.strsplit(string.sub(p, psize - limit, -1), '/')
                    -- dump(names)
                    if #names > 1 then
                        return '</' .. table.concat(names, '/', 2, #names)
                    end
                end
                return p
            end,
        },
        filters = {
            custom = { "^.git", "^.tags", "^.cache", "^.init", "^.svn", "__pycache__" },
            dotfiles = true,
        },
        update_focused_file = {
            enable = true,
            update_root = true,
        },
        actions = {
            use_system_clipboard = false,
            file_popup = {
                open_win_config = {
                    col = 1,
                    row = 1,
                    relative = "cursor",
                    border = "shadow",
                    style = "minimal",
                },
            },
            open_file = {
                window_picker = {
                    enable = true,
                    chars = "asdfghjl",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                }
            },
        },
        tab = {
            sync = {
                open = false,
                close = false,
                ignore = {},
            },
        },
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            local function opts(desc)
              return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            local function open_then_close(node)
                api.node.open.edit(node)
                api.tree.close()
            end

            -- BEGIN_DEFAULT_ON_ATTACH
            vim.keymap.set('n', 'cd', api.tree.change_root_to_node,          opts('CD'))
            -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
            -- vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
            -- vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
            vim.keymap.set('n', 'O',     open_then_close,                       opts('Open: Close after Jump'))
            vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open: In Place'))
            vim.keymap.set('n', 't',     api.node.open.tab,                     opts('Open: New Tab'))
            vim.keymap.set('n', 'v',     api.node.open.vertical,                opts('Open: Vertical Split'))
            vim.keymap.set('n', 'x',     api.node.open.horizontal,              opts('Open: Horizontal Split'))
            vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
            vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open: In Place'))
            vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
            vim.keymap.set('n', '<C-j>',     api.node.navigate.sibling.next,    opts('Next Sibling'))
            vim.keymap.set('n', '<C-k>',     api.node.navigate.sibling.prev,    opts('Previous Sibling'))
            -- vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
            vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
            -- vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
            -- vim.keymap.set('n', 'bd',      api.marks.bulk.delete,               opts('Delete Bookmarked'))
            -- vim.keymap.set('n', 'bt',      api.marks.bulk.trash,                opts('Trash Bookmarked'))
            -- vim.keymap.set('n', 'bmv',     api.marks.bulk.move,                 opts('Move Bookmarked'))
            -- vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
            -- vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
            -- vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
            -- vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
            -- vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
            -- vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
            -- vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
            vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
            -- vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
            -- vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
            -- vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
            -- vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
            -- vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
            vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
            vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
            vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
            vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
            vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
            vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
            vim.keymap.set('n', 'mm',    api.marks.toggle,                      opts('Toggle Bookmark'))
            -- vim.keymap.set('n', 'ma',    api.marks.list,                      opts('List Bookmark'))
            vim.keymap.set('n', 'M',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
            -- vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
            vim.keymap.set('n', 'p',     api.node.navigate.parent,              opts('Parent Directory'))
            vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
            vim.keymap.set('n', 's[',    api.tree.close,                        opts('Close'))
            -- vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
            vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
            -- vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
            vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
            vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
            vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
            -- vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
            -- TODO: error with nvim-neoclip autocmd
            -- vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
            -- vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
            vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open: In Place'))
            vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        end
    }

    _G.nvim_tree_open_cwd = function(cwd)
        local api = require("nvim-tree.api")
        if cwd == 1 then
            vim.cmd('lcd ' .. '%:p:h')
            api.tree.toggle({path = vim.fn.getcwd()})
        else
            api.tree.toggle()
        end
    end

    _G.nvim_tree_open_update = function(flag)
        local api = require("nvim-tree.api")
        vim.cmd('lcd ' .. '%:p:h')
        local pwd = vim.fn.getcwd()
        if flag == 1 then
            api.tree.toggle({path = pwd})
        else
            api.tree.close()
            api.tree.open({ path = pwd })
            vim.cmd('winc w')
        end
    end

    _G.nvim_tree_open_cfile = function()
        local api = require("nvim-tree.api")
        local p1 = vim.fn.getcwd()
        vim.cmd([[
            let g:nvim_tmp_flag = 0
            let cfile = expand('<cfile>:p')
            echomsg "cfile " . cfile
            if isdirectory(cfile)
                let g:nvim_tmp_flag = 1
                exec 'lcd ' . cfile
            elseif filereadable(cfile)
                let g:nvim_tmp_flag = 2
                let line = ''
                try
                    let [_, pattern, line; __] = matchlist(getline("."), '\v.*(' . cfile . ')\s*:\~*(\d*).*$')
                catch
                endtry
                exec 'tabedit!' . cfile
                if line != ''
                    silent! exec line
                endif
            else
                let g:nvim_tmp_flag = 3
                exec 'Leaderf file --no-ignore --cword'
            endif
        ]])
        if 1 == vim.g.nvim_tmp_flag then
            local p2 = vim.fn.getcwd()
            if p1 ~= p2 then
                api.tree.close()
                api.tree.open({path = p2})
            end
        end
    end
    require("nvim-tree").setup(conf)
    require("nvim-web-devicons").set_icon {
        toml = {
            icon = "",
            color = "#ffffff",
            cterm_color = "231",
            name = "Toml",
        },
    }
end

return CONFIG
