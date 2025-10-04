-- There are 4 different view types:
--   1. thin
--   2. long
--   3. wide
--   4. tree
vim.g.netrw_liststyle = 3

-- Changing how files are opened
--    1 - open files in a new horizontal split
--    2 - open files in a new vertical split
--    3 - open files in a new tab
--    4 - open in previous window
vim.g.netrw_browse_split = 3
vim.g.netrw_liststyle = 3

-- Set the width of the directory explorer
vim.g.netrw_winsize = 40

-- Tell netrw to open files in the previously active window
vim.g.netrw_browse_split = 4

-- use netrw instead, 🤘
vim.keymap.set('n', '<C-n>', function()
  -- Check if the current buffer has filetype 'netrw'
  if vim.bo.filetype == 'netrw' then
    -- Use :bwipeout to close the window AND remove the buffer from the list
    vim.cmd('bwipeout')
  else
    -- Otherwise, open Netrw in a vertical split (Lexplore)
    vim.cmd('Lexplore')
  end
end, { desc = 'Toggle Netrw Explorer and Wipeout Buffer', silent = true })

