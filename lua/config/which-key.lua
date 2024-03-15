local CONFIG = {}

function CONFIG.setup()
    local wk = require("which-key")
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    local conf = {-- {{{
        plugins = {
            marks = false, -- ' and `
            registers = false, -- " and c-r in insert mode
            spelling = {
                enabled = false,
                suggestions = 20,
            },
        },
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
        key_labels = {
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        triggers_nowait = {
            -- marks
            "`", "g`",
            -- registers
            '"', "<c-r>",
            -- other
        },
        triggers_blacklist = {
            i = { "j", "k", "l", "h", "'" },
            v = { "j", "k", "l", "h" },
            n = { "j", "k", "l", "h", "c", "d", "y", "," },
      },
      disable = {
        buftypes = {},
        filetypes = {}, --  {"NvimTree", "Outline"},
      },
    }-- }}}
    wk.setup(conf)

    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>")
    vim.keymap.set("n", "D", function() vim.diagnostic.open_float(nil, { focus = false }) end)

    local km_g = {-- {{{
        -- lsp
        ["d"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
        ["h"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Goto Signature Help" },
        ["a"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Goto Implementation / Headers" },

        -- Lspsaga
        ["f"] = { "<cmd>Lspsaga finder<cr>", "Saga Finder" },
        ["]"] = { "<cmd>Lspsaga goto_definition<cr>", "Saga Goto Definition" },
        ["i"] = { "<cmd>Lspsaga incoming_calls<cr>", "Saga Incoming Calls" },
        ["o"] = { "<cmd>Lspsaga outgoing_calls<cr>", "Saga Outgoing Calls" },
        ["t"] = { "<cmd>Lspsaga goto_type_definition<cr>", "Saga Goto Type Definition" },
        ["l"] = {
            name = "Lspsaga & Lsp",
            ["d"] = { "<cmd>Lspsaga peek_definition<cr>", "Saga Peek Definition" },
            ["t"] = { "<cmd>Lspsaga peek_type_definition<cr>", "Saga Peek Type Definition" },
            ["r"] = { "<cmd>Lspsaga rename<cr>", "Saga Rename" },
            ["a"] = { "<cmd>Lspsaga code_action<cr>", "Saga Code Action"},
            ["i"] = { "<cmd>LspInfo<cr>", "Lsp Info" },
            ["n"] = { "<cmd>NullLsInfo <cr>", "NullLs Info" },
            ["l"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run CodeLens" },  -- 引用
            ["L"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh CodeLens" },
            ["F"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format Document" }
        },

        -- bufferline tabpage
        ["s"] = { "<cmd>BufferLinePick<cr>", "TabPage Select One" },
        ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 1" },
        ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 2" },
        ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 3" },
        ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 4" },
        ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 5" },
        ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 6" },
        ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 7" },
        ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 8" },
        ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 9" },
        ["0"] = { "<cmd>BufferLineGoToBuffer -1<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus Last" },
        ["!"] = { "<cmd>0tabmove<cr>", "TabPage Move toFirst" },
        [")"] = { "<cmd>tabmove<cr>",  "TabPage Move toLast" },
    }
    wk.register({ g = km_g }, { mode = "n", silent = true, nowait=true })-- }}}

    local km_s = {-- {{{
        -- nvim-tree
        ["["] = { "<cmd>lua nvim_tree_open_update(1)<cr>", "Nvim Tree Open"},
        -- ["{"] = { "<cmd>lua nvim_tree_open_update(2)<cr>", "Nvim Tree Update"},

        -- Lspsaga
        ["]"] = { "<cmd>Lspsaga outline<cr>", "Saga Outline" },
        ["}"] = { "<cmd>Lspsaga outline<cr><cmd>Lspsaga outline<cr>", "Saga Outline Update" },

        -- leaderf
        ["b"] = { "<cmd>silent Leaderf! buffer<cr>", "Leaderf Display Buffers" },
        ["c"] = { "<cmd>silent Leaderf! cmdHistory --popup<cr>", "Leaderf Cmd History" },
        ["C"] = { "<cmd>silent Leaderf  command --popup<cr>", "Leaderf Find Command" },
        ["h"] = { "<cmd>silent Leaderf! searchHistory --popup<cr>", "Leaderf Search Histroy" },
        ["n"] = { "<cmd>silent Leaderf! mru --nowrap --popup<cr>", "Leaderf MRU Files" },
        ["."] = { "<cmd>silent Leaderf! function --nowrap<cr>", "Leaderf Functions" },
        [">"] = { "<cmd>silent Leaderf! function --all --nowrap --stayOpen<cr>", "Leaderf All Functions" },
        ["S"] = { "<cmd>silent Leaderf rg --nowrap --current-buffer --ignore-case<cr>", "Leaderf Search String (living)" },
        ["s"] = "Leaderf Search String (cword + buffer)",
        ["+"] = "Leaderf Search String (cword + buffer + append)",
        ["/"] = "Leaderf Search String (cword + input-dir)",
        ["?"] = "Leaderf Search String (xclip + input-dir)",
        ["w"] = { "<cmd>silent Leaderf! --recall<cr>", "Leaderf Resume Result" },

        -- telescope
        ["H"] = { "<cmd>lua require('telescope.builtin').highlights()<cr>", "Display Highlights" },
        ["g"] = { "<cmd>lua custom_git_grep_string()<cr>", "Live Grep from Git WS(cword)" },
        ["G"] = { "<cmd>lua custom_git_live_grep()<cr>", "Live Grep from Git WS" },
        ["j"] = { "<cmd>Telescope jumplist show_line=true fname_width=40 trim_text=true<cr>", "Telescope jumplist" },
        ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", "Star Projects" },
        ["P"] = { "<cmd>lua custom_bookmark_add_project()<cr>", "Add Project" },
        ["k"] = { "<cmd>lua require('telescope.builtin').keymaps({theme='dropdown', layout_config={width=0.8}})<cr>", "Key Maps" },
        ["q"] = { "<cmd>lua require('telescope.builtin').registers()<cr>", "Registers" },
        ["m"] = { "<cmd>Telescope neoclip<cr>", "Neoclip" },
        ["M"] = { "<cmd>Telescope macroscope<cr>", "Macroscope" },
    }
    wk.register({ s = km_s }, { mode = "n", silent = true, nowait=true })-- }}}

    local km_f = {-- {{{
        -- telescope
        ["f"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Telescope Find Files" },
        ["g"] = { "<cmd>lua custom_telescope_find_files()<cr>", "Telescope Files from Git WS" },
        ["w"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Telescope Float Window Resume" },

        -- leaderf
        ["/"] = "Leaderf Find Files (cfile + input-dir)",
        ["?"] = "Leaderf Find Files (xclip + input-dir)",
    }
    wk.register({ f = km_f }, { mode = "n", silent = true, nowait=false })-- }}}

    local km_m = {-- {{{
        -- marks
        ["a"] = { "<cmd>Telescope marks mark_type=local<cr>", "All Marks Browser" },
        ["m"] = { "<cmd>lua require'marks'.toggle()<cr>", "Local Marks" },
        ["x"] = { "<cmd>lua require'marks'.delete_buf()<cr>", "Clear all Marks" },
        -- ["M"] = { "<cmd>lua custom_place_upper_mark()<cr>", "Global Marks" },
        -- ["q"] = { "<cmd>Telescope marks mark_type=local<cr>", "Local Marks Browser" },

    }
    wk.register({ m = km_m }, { mode = "n", silent = true, nowait=true })-- }}}

    local km_d = {-- {{{
        -- d%, da, db: delete back word dw: delete next word df/dF: delete by find char
        ["]"] = { "<cmd>lua vim.diagnostic.setqflist({open = false})<cr><cmd>lua require('utils.window').toggle_open_qflist()<cr>", "diagnostic to qflist (all)" },

        ["x"] = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "show buffer diagnostics"},
        -- ["X"] = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "show workspace diagnostics"},

        ["n"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "diagnostic goto next" },
        ["p"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "diagnostic goto prev" },

        ["N"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>", "diagnostic(error) goto next" },
        ["P"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>", "diagnostic(error) goto prev" },
    }
    wk.register({ d = km_d }, { mode = "n", silent = true, nowait=true })-- }}}

    -- keymap specific prefix{{{
    wk.register({
        -- nvim-tree
        ["<C-]>f"] = { "<cmd>lua nvim_tree_open_cfile()<cr>", "Open Current File"},

        ["<C-]>v"] = { "<cmd>Lspsaga goto_definition vsplit<cr>", "Saga Goto Definition v" },
        ["<C-]>x"] = { "<cmd>Lspsaga goto_definition split<cr>", "Saga Goto Definition h" },
        ["<C-]>t"] = { "<cmd>Lspsaga goto_definition tabnew<cr>", "Saga Goto Definition t" },

        -- windowsmaximize
        ["<C-x>"] = { "<cmd>WindowsMaximize<cr>", "Maximizer Toggle Window" },
        ["<C-=>"] = { "<cmd>WindowsEqualize<cr>", "Maximizer Equalize Window" },

        -- colormark
        ["\\"] = {
            name = "ColorMark",
            ["m"] = "Toggle Color Mark",
            ["M"] = "Toggle @ Color Mark Manauly",
            ["x"] = "Clear all Color Marks",

            ["]"] = "Search Next Current Mark",
            ["["] = "Search Previous Current Mark",
            ["}"] = "Search Next Any Mark",
            ["{"] = "Search Previous Any Mark",

            ["n"] = "Search Next Current Mark",
            ["N"] = "Search Previous Current Mark",
            ["p"] = "Search Next Any Mark",
            ["P"] = "Search Previous Any Mark",
        },

        -- VCS
        ["]c"] = {
            name = "Git Commands",
            ["a"] = "VCS ADD",
            ["c"] = "VCS Commit",
            ["d"] = "VCS Diff",
            ["l"] = "VCS Log",
            ["q"] = "VCS Revert",
            ["r"] = "VCS Review",
            ["v"] = "VCS Vim Diff",

            -- neogit
            ["g"] = { "<cmd>Neogit<cr>", "NeoGit" },

            -- telescope
            ["s"] = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "VCS Status" },
        },

        ["[w"] = { name = "L window Hydra", },
        ["]w"] = { name = "C window Hydra", },

        -- alt-0 ... alt-9: only maximizer split horizontal in terminator
        ["<M-1>"] = { "<cmd>BufferLineGoToBuffer 1<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 1" },
        ["<M-2>"] = { "<cmd>BufferLineGoToBuffer 2<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 2" },
        ["<M-3>"] = { "<cmd>BufferLineGoToBuffer 3<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 3" },
        ["<M-4>"] = { "<cmd>BufferLineGoToBuffer 4<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 4" },
        ["<M-5>"] = { "<cmd>BufferLineGoToBuffer 5<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 5" },
        ["<M-6>"] = { "<cmd>BufferLineGoToBuffer 6<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 6" },
        ["<M-7>"] = { "<cmd>BufferLineGoToBuffer 7<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 7" },
        ["<M-8>"] = { "<cmd>BufferLineGoToBuffer 8<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 8" },
        ["<M-9>"] = { "<cmd>BufferLineGoToBuffer 9<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus 9" },
        ["<M-0>"] = { "<cmd>BufferLineGoToBuffer -1<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "Tabpage Focus Last" },
        ["<M-!>"] = { "<cmd>0tabmove<cr>", "TabPage Move toFirst" },
        ["<M-)>"] = { "<cmd>tabmove<cr>",  "TabPage Move toLast" },
        ["<M-s>"] = { "<cmd>BufferLinePick<cr>", "TabPage Select One" },
        ["<M-/>"] = { "<cmd>silent tabnext #<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "TabPage Goto Last Access" },
        ["<M-q>"] = { "<cmd>BufferLineCycleNext<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "TabPage Focus Loop" },
        ["<M-,>"] = { "<cmd>BufferLineCyclePrev<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "TabPage Focus Prev" },
        ["<M-.>"] = { "<cmd>BufferLineCycleNext<cr><cmd>MyNvimTreeSwitchBuffer<cr>", "TabPage Focus Next" },
        ["<M-<>"] = { "<cmd>-tabmove<cr>", "TabPage Move toPrev" },
        ["<M->>"] = { "<cmd>+tabmove<cr>", "TabPage Move toNext" },
    }, { mode = { "n" }, silent = true, nowait = true  })-- }}}

    wk.register({
        -- LspSaga
        ["<C-\\>"] = { "<cmd>Lspsaga term_toggle<cr>", "Saga Term Toggle" },

    }, { mode = { "n", "t" }, silent = true, nowait = true })

    -- keymap leader prefix{{{
    wk.register({
        -- Commnet
        ["c"] = {
            name = "Comment",
            ["<space>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment Current Line" },
        },

        -- Fast Hop/Leap
        ["f"] = "Jump nextward (Leap)",
        ["F"] = "Jump backward (Leap)",
        [","] = {
            name = "Hop / Fast Move",
            ["w"] = { "<cmd>HopWordCurrentLine<cr>", "Hop Word" },
            ["l"] = { "<cmd>HopLineStart<cr>",       "Hop Line" },
            ["j"] = { "<cmd>HopLineStartAC<cr>",     "Hop Line After Cursor" },
            ["k"] = { "<cmd>HopLineStartBC<cr>",     "Hop Line Before Cursor" },

            -- fast move (affect lsp cmp)
            ['m'] = { "Hydra Fast Move" },
        },

        ["o"] = {
            name = "Overseer",
            ["o"] = { "<cmd>OverseerToggle<cr>", "OverseerToggle" },
            ["c"] = { "<cmd>lua custom_overseer_compile()<cr>", "Compile" },
            ["r"] = { "<cmd>OverseerQuickAction restart<cr>", "OverseerQuickAction Restart" },
            ["w"] = { "<cmd>OverseerQuickAction open output in quickfix<cr>", "OverseerQuickAction Quickfix" },
            ["a"] = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
            ["t"] = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
            ["l"] = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
            ["s"] = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
            ["d"] = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
            ["C"] = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
        },

        ["j"] = {
            name = "Jupyter(iron)",
            -- ["j"] = { "<cmd>IronFocus python<cr><cmd>norm i<cr>", "Jupyter On" },
            ["j"] = { "<cmd>IronRepl python<cr>", "Jupyter On/Off" },
            ["J"] = { "<cmd>IronRestart<cr>", "Jupyter Restart" },
            ["x"] = "Jupyter Interrupt",
            ["c"] = { "<cmd>lua custom_iron_clear()<cr>", "Jupyter Clear" },
            ["q"] = { "<cmd>lua custom_iron_quit()<cr>", "Jupyter Quit" },
            ["l"] = "Jupyter Send Line",
            ["f"] = "Jupyter Send File",
            ["s"] = "Jupyter Send Motion",
            ["u"] = "Jupyter Send Util Cursor",
            ["t"] = "Jupyter Send <Tag></Tag>",
            ["p"] = "Jupyter Send Paragrah",
            ["m"] = "Jupyter Send Function",
        },

        ["t"] = {
            name = "Translate",
            ["r"] = { "<cmd>Translate<cr>", "Translate in Console" },
            ["w"] = { "<cmd>TranslateW<cr>", "Translate in Window" },
        },

        -- vim-bookmark
        ["m"] = {
            name = "Vim Bookmark",
            ["a"] = { "<cmd>lua custom_telescope_bookmarks()<cr>", "Bookarks Show All" },
            ["q"] = { "<cmd>silent Telescope ntree_marks<cr>", "Bookarks NvimTree" },
            ["m"] = { "<cmd>lua wrap_runcmd('BookmarkToggle')<cr>",   "Bookarks Toggle Mark" },
            ["M"] = { "<cmd>lua wrap_runcmd('BookmarkAnnotate', 1)<cr>", "Bookarks Annotate" },
            ["x"] = { "<cmd>lua wrap_runcmd('BookmarkClearAll')<cr>", "Bookarks Clear All" },
        },

        ["d"] = {
            name = "Draw",

            -- draw ascii(hydra)
            ["v"] = "Start DrawIt",

            -- draw markdown preview: web
            ["p"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview Toggle" },
        },
    }, { mode = "n", prefix = "<leader>", silent = true })-- }}}

    -- visual mode{{{
    wk.register({
        -- Commnet
        ["c"] = {
            name = "Comment",
            ["<space>"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment Block" },
        },
        ["t"] = {
            name = "Translate",
            ["r"] = { "<Plug>TranslateV", "V:Translate in Console" },
            ["w"] = { "<Plug>TranslateWV", "V:Translate in Window" },
        },
        ["a"] = {
            name = "Mini Align",
            ["s"] = "Enter split Lua pattern",
            ["j"] = "Choose justification side",
            ["m"] = "Enter merge delimiter",
            ["f"] = "Enter filter Lua expression",
            ["i"] = "Ignore some commonly unwanted split matches",
            ["p"] = "Pair neighboring parts so they be aligned together",
            ["t"] = "Trim whitespace from parts",
        },
    }, { mode = "v", prefix = "<leader>", sielent = true })-- }}}
end

return CONFIG
