local function format_configs(_, bufnr)
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>',
    { noremap = true, silent = true })
end

local function on_init(client)
  local path = client.workspace_folders[1].name
  if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      }
    })

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
  return true
end

local configs = {
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
}

local M = {}

function M.setup()
  --local lspconfig = 
  local cmp = require('cmp_nvim_lsp')
  local capabilities = cmp.default_capabilities()
  -- Configure lua-lsp
  require('lspconfig').lua_ls.setup {
    on_attach = format_configs,
    cmd = { "lua-language-server" },
    on_init = on_init,
    settings = configs,
    capabilities = capabilities
  }
end

return M
