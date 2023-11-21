local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
    capabilities = capabilities
}

require('change-color')

