local lspconfig = require('lspconfig')

local init_path = '~/.config/nvim/init.lua'
if os.getenv("NIX_DEV_MODE") then
  init_path = os.getenv("XDG_CONFIG_HOME") .. '/nvim/init.lua'
end
local M = {}
local caps = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities(),
  -- See: https://github.com/neovim/neovim/pull/22405
  { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
);
function M.setup()
  lspconfig.lua_ls.setup {
    on_attach = function(_, buffer)
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>',
        { noremap = true, silent = true })
    end
    ,
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT', -- Use 'LuaJIT' or 'Lua5.1'
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          enable = true,
          globals = { 'vim', 'nvim', 'my_init' },
        },
        workspace = {
          checkThirdParty = true,
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            [init_path] = true,
          },
        },
      },
    },
    capabilities = caps
  }
end

return M
