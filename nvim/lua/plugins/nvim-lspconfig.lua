-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

--[[
Language servers setup:
For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
Bash --> bashls
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
Python --> pyright
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
C-C++ --> clangd
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
JavaScript/TypeScript --> tsserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
--]]

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function()
  return vim.fn.getcwd()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:

local nvim_lsp = require('lspconfig')

nvim_lsp['gopls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
  single_file_support = true,
  settings = {
    gopls = {
      buildFlags = {"-tags=integration"},
    },
  },
}

nvim_lsp['tsserver'].setup{
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  single_file_support = true,
}

nvim_lsp['terraformls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform" },
  root_dir = nvim_lsp.util.root_pattern(".terraform", ".git"),
}

nvim_lsp['rls'].setup{
  cmd = { "rls" },
  filetypes = { "rust" },
  root_dir = nvim_lsp.util.root_pattern("Cargo.toml"),
  all_features = true,
}

nvim_lsp['sorbet'].setup{
  cmd = {"srb", "tc", "--lsp"},
  filetypes = { "ruby" },
  root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git")
}

nvim_lsp['ccls'].setup{
  cmd = { "ccls" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cxx"},
  offset_encoding = "utf-32",
  root_dir = nvim_lsp.util.root_pattern("compile_commands.json", ".ccls", ".git"),
  single_file_support = false,
  cache = {
    directory = ".ccls-cache",
  },
}

nvim_lsp['jedi_language_server'].setup{
  cmd = { "jedi-language-server" },
  filetypes = { "python" },
  single_file_support = true,
}

nvim_lsp['svelte'].setup {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
}

nvim_lsp['nomad_lsp'].setup {
  cmd = { "nomad-lsp" },
  filetypes = { "hcl.nomad", "nomad" },
  root_dir = nvim_lsp.util.root_pattern("hcl.nomad", "nomad"),
}

nvim_lsp['csharp_ls'].setup {
  cmd = { "csharp-ls" },
  filetypes = { "cs" },
  init_options = {
    AutomaticWorkspaceInit = true
  },
  root_dir = nvim_lsp.util.root_pattern("Assembly-CSharp.csproj", ".sln"),
}
