local CONFIG = {}

function CONFIG.setup()
    local conf = {
        level = vim.log.levels.INFO,
        timeout = 1000,
        -- background_colour = "NotifyBackground",
        minimum_width = 30,
        fps = 30,
        top_down = true,
        icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
        },
    }
    local notify = require("notify")
    notify.setup(conf)
    vim.notify = notify
    -- vim.ui_attach(
    --     vim.api.nvim_create_namespace("redirect messages"),
    --     { ext_messages = true },
    --     function(event, ...)
    --         if event == "msg_show" then
    --             local level = vim.log.levels.INFO
    --             local kind, content = ...
    --             if string.find(kind, "err") then
    --                 level = vim.log.levels.ERROR
    --             end
    --             vim.notify(content, level, { title = "Message" })
    --         end
    --     end
    -- )
end

return CONFIG
