local CONFIG = {}

_G._fuzzyfinder_loaded = 0

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'fuf')

function CONFIG.setup()
    if _G._fuzzyfinder_loaded == 0 then
        vim.cmd([[
            let g:fuf_previewHeight = 0      "预览高度
            let g:fuf_enumeratingLimit = 100 "符合条件的最多显示20个
            let g:fuf_modesDisable = [
                 \ 'buffer', 'line', 'mrucmd', 'file', 'dir',
                 \ 'tag', 'buffertag', 'help', 'taggedfile',
                 \ 'jumplist', 'mrufile', 'changelist', 'quickfix',
            \ ]
            let g:fuf_maxMenuWidth = 200
            let g:fuf_autoPreview = 0
            let g:fuf_promptHighlight = 'Question'
            let g:fuf_ignoreCase = 1
            let g:fuf_timeFormat = '(%Y-%m-%d %H:%M:%S)'
            let g:fuf_reuseWindow = 1

            let g:fuf_keyOpen = 'o'
            let g:fuf_keyOpenSplit = 'x'
            let g:fuf_keyOpenVsplit = 'v'
            let g:fuf_keyOpenTabpage = 't'

            let g:fuf_keyPrevMode = '@null'
            let g:fuf_keyNextMode = '@null'
            let g:fuf_keyPrevPattern = '@null'
            let g:fuf_keyNextPattern = '@null'
            let g:fuf_keyPreview = '@null'

            let g:fuf_dataDir = g:nvim_cache_path
            let g:priv_fuf_dir_openmode = 'NvimTreeOpen'

            " nnoremap <unique> <silent> su  :FufBookmarkFile<CR>
            " nnoremap <unique> <silent> sU  :FufBookmarkFileAdd<CR>
            " nnoremap <unique> <silent> si  :FufBookmarkDir<CR>
            " nnoremap <unique> <silent> sI  :FufBookmarkDirAdd<CR>
        ]])
    end
    _G._fuzzyfinder_loaded = 1
end

return CONFIG
