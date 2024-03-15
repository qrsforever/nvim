local CONFIG = {}

function CONFIG.setup()
    if os.getenv('RSYNC') then
        vim.cmd([[
            let g:sync_exe_filenames = '.vim-sync;'
            let g:sync_async_upload = 1
            let g:sync_async_silent = 1
            autocmd BufWritePost * :call SyncUploadFile()
        ]])
    end
end

return CONFIG
