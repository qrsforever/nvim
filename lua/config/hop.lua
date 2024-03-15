local CONFIG = {}

function CONFIG.setup()
    local conf = {
        keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    }
    require("hop").setup(conf)
end

return CONFIG
