local CONFIG = {}

function CONFIG.setup()
    vim.cmd([[
        let VCSCommandDisableMappings = 0
        let VCSCommandEnableBufferSetup = 0  "slow if set 1
        let VCSCommandVCSTypePreference = ['git', 'bzr', 'svn', 'hg']
        let VCSCommandMapPrefix = ']c'
        " see vim-gitgutter key map
        let VCSCommandMappings = [
        \ ['a', 'VCSAdd'],
        \ ['c', 'VCSCommit'],
        \ ['d', 'VCSDiff'],
        \ ['l', 'VCSLog'],
        \ ['q', 'VCSRevert'],
        \ ['r', 'VCSReview'],
        \ ['v', 'VCSVimDiff'],
        \]

        augroup VCSCommand
        au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
        augroup END
    ]])
end

return CONFIG
