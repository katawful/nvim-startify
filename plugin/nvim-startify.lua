--[[

Plugin: https://github.com/katawful/nvim-startify
Description: Neovim recreation of vim-startify for extensibility
Maintainer: Kat <katisntgood@gmail.com>

--]]

-- Don't run this file more than once
if vim.fn.exists("g:loaded_startify") == 1 then
    return
end
vim.g.loaded_startify = 1
vim.g.startify_locked = 0

-- Offload onto proper Lua file for better management
if vim.fn.has("nvim") == 1 then
    require("nvim-startify.main").init()
end
