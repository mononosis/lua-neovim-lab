local lspconfig = require('lspconfig')
-- Configure lua-lsp
lspconfig.lua_ls.setup {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT', -- Use 'LuaJIT' or 'Lua5.1'
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'nvim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}

-- Add this at the beginning of your init.lua
local current_dir = '/home/nixos/Lab/LuaLab/lua-neovim-lab'
package.path = package.path .. ';' .. current_dir .. '/?.lua'

-- Rest of your code...
require('change-color')

