_G.dump = function(...)
    print(vim.inspect(...))
end

_G.prequire = function(...)
    local status, lib = pcall(require, ...)
    if status then
        return lib
    end
    return nil
end

_G.reload = function(module)
    local r = require "plenary.reload"
    r.reload_module(module)
end

_G.wrap_runcmd = function(cmd, ch)
    if ch then
        local ch_old = vim.o.cmdheight
        vim.cmd('set cmdheight=' .. ch)
        vim.cmd('silent! ' .. cmd)
        vim.cmd('set cmdheight=' .. ch_old)
    else
        vim.cmd('silent! ' .. cmd)
    end
end

local UTIL = {}
-- local lfs = require("lfs")

function UTIL.nvim_config_path()
    return vim.fn.stdpath('config')
end

function UTIL.nvim_cache_path()
    return vim.fn.stdpath('cache')
end

function UTIL.t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function UTIL.exists(list, val)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set[val]
end

function UTIL.log(msg, hl, name)
    name = name or "Neovim"
    hl = hl or "Todo"
    vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function UTIL.warn(msg, name)
    vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function UTIL.error(msg, name)
    vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function UTIL.info(msg, name)
    vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function UTIL.is_empty(s)
    return s == nil or s == ""
end

function UTIL.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

function UTIL.quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if modified then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd "q!"
            end
        end)
    else
        vim.cmd "q!"
    end
end

function UTIL.dirname(str, sep)
    sep = sep or '/'
    return str:match("(.*"..sep..")")
end

function UTIL.basename(url)
    -- return url:match("^.+/(.+)$")
    local name = string.gsub(url, "(.*/)(.*)", "%2")
    return name
end

function UTIL.basename_without_extension(url)
    url = string.gsub(url, "(.*/)(.*)", "%2")
    return url:match("(.+)%..+$")
end

function UTIL.file_extension(url)
    return url:match("^.+(%..+)$")
end

function UTIL.strsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function UTIL.wsdir(url)
    local path = ''
    local rel_path = ''
    for str in string.gmatch(url, "([^/]+)") do
        path = path .. "/" .. str
        if vim.fn.isdirectory(path .. "/.git") == 1 then
        -- for git submodule
        -- if vim.fn.exists(path .. "/.git") == 1 then
            rel_path = path
        end
    end
    return rel_path
end

return UTIL
