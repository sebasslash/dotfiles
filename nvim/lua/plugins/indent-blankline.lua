local status_ok, indent_blankline = pcall(require, 'ibl')
if status_ok then
  indent_blankline.setup {
    scope = {
      enabled = true,
    },
    indent = {
      char = "▏",
    },
    exclude = {
      filetypes = {
        'help',
        'dashboard',
        'git',
        'markdown',
        'text',
        'terminal',
        'lspinfo',
        'packer',
        'NvimTree',

      },
      buftypes = {
        'terminal',
        'nofile',
      },
    },
  }
else
  return
end


