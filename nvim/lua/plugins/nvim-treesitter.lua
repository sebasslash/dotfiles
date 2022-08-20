-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter


local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', "rust", "ruby", 'html', 'javascript', 'json', 'lua', 'python',
    'typescript', 'vim'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
}

require('nvim-ts-autotag').setup {
  filetypes = {
    'html', 'svelte', 'markdown', 'hbs', 'handlebars'
  }
}
