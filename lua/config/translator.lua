local CONFIG = {}

_G._translator_loaded = 0

-- table.insert(_G.ignore_filetypes, 'xx')

function CONFIG.setup()
    if _G._translator_loaded == 0 then
        vim.cmd([[
            let g:translator_target_lang = 'zh'
            let g:translator_source_lang = 'en'
            let g:translator_default_engines = ['bing', 'youdao']
            let g:translator_history_enable = 'false'
            let g:translator_window_type = 'popup'
            let g:translator_window_max_width = 0.6
            let g:translator_window_max_height = 0.6
            " let g:translator_proxy_url = 'socks5://127.0.0.1:1080'
            nnoremap <silent><expr> <M-f> translator#window#float#has_scroll() ? translator#window#float#scroll(1) : "\<M-f>"
            nnoremap <silent><expr> <M-b> translator#window#float#has_scroll() ? translator#window#float#scroll(0) : "\<M-b>"
        ]])
    end
    _G._translator_loaded = 1
end

return CONFIG
