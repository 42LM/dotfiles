local actions = require('telescope.actions')
local layout_actions = require('telescope.actions.layout')

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ['<S-p>'] = layout_actions.toggle_preview,
        ['<C-a>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      i = {
        ['<S-p>'] = layout_actions.toggle_preview,
        ['<C-a>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 200,
        -- width = 0.9, -- << was this before
      },
    },
    live_grep = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 200,
      },
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 200,
      },
    },
    help_tags = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 200,
      },
    },
  },
  extensions = {}
}

vim.keymap.set('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>fg', '<Cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files,--column--line_number,--no-heading,--color=always,--smart-case<CR>')
vim.keymap.set('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fh', '<Cmd>Telescope help_tags<CR>')
