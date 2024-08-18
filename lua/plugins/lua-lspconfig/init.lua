local lspconfig = require('lspconfig')

local init_path = '~/.config/nvim/init.lua'
-- Custom hover function to control the floating window position
if os.getenv("NIX_DEV_MODE") then
  init_path = os.getenv("XDG_CONFIG_HOME") .. '/nvim/init.lua'
end

local M = {}
--local caps = vim.tbl_deep_extend(
  --'force',
  --vim.lsp.protocol.make_client_capabilities(),
  --require('cmp_nvim_lsp').default_capabilities(),
  ---- See: https://github.com/neovim/neovim/pull/22405
  --{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
--);
function M.setup()
  lspconfig.luau_lsp.setup {}
  lspconfig.lua_ls.setup {
    on_init = function(client)
      --local path = client.workspace_folders[1].name
      --print(path)
      --if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      --return
      --end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          globals = { 'vim', 'nvim', 'my_init', },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            init_path
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
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

      vim.api.nvim_buf_set_keymap(buffer, 'n', 'K', '<cmd>lua custom_hover()<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>s', '<cmd>source %<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>t', '<cmd>!lua %<CR>', { noremap = true, silent = true })
    end
    ,
    cmd = { "lua-language-server" },
    settings = {
      Lua = {}
    }
    --settings = {
    --Lua = {
    --runtime = {
    --version = 'LuaJIT', -- Use 'LuaJIT' or 'Lua5.1'
    --path = vim.split(package.path, ';'),
    --},
    --diagnostics = {
    --enable = true,
    --globals = { 'vim', 'nvim', 'my_init', },
    --},
    --workspace = {
    ----checkThirdParty = true,
    --library = {
    ----[vim.fn.expand('$VIMRUNTIME/lua')] = true,
    --vim.env.VIMRUNTIME,
    ----[vim.fn.expand('$VIMRUNTIME')] = true,
    ----[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
    --init_path --] = true,
    --},
    --},
    --},
    --},
    --capabilities = caps
  }
end

return M
