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

require('change-color')

