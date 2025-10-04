-- Mappings are noremap by defaul
local keymap = vim.keymap

-- GENERAL {{{
-- *****************************************************************************

-- map 'jk' to 'ESCAPE'
keymap.set('i', 'jk', '<ESC>')

-- Custom function to set the location list with a custom format
local function set_list_with_source()
  vim.diagnostic.setloclist({
    open = true,
    format = function(diagnostic)
      -- Formats as: [Source] Message
      return string.format('[%s] %s', diagnostic.source, diagnostic.message)
    end,
  })
end

-- Map a key to call this function (e.g., Leader-dl)
vim.keymap.set('n', '<leader>dl', set_list_with_source, { desc = 'LSP Buffer Diagnostics (Source)' })

-- map 'CONTROL+n' to nerdtree
-- nmap <C-n> :NERDTreeToggle<CR>

-- Autocommand to automatically wipeout netrw buffers when they are hidden
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    -- Set bufhidden=wipe to ensure the buffer is removed completely 
    -- (like :bwipeout) when the window containing it is hidden/closed.
    vim.opt_local.bufhidden = 'wipe'
  end
})

-- cycle through buffers
vim.keymap.set('n', 'gt', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'gT', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- set new emmet leader key
vim.g.user_emmet_leader_key = ','

-- Seamlessly treat visual lines as actual lines when moving around.
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')
keymap.set('n', '<Down>', 'gj')
keymap.set('n', '<up>', 'gk')
keymap.set('i', '<down>', '<C-o>gj')
keymap.set('i', '<up>', '<C-o>gk')

-- SPLITS
-- move between splits
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')
keymap.set('n', 's<left>', '<C-w>h')
keymap.set('n', 's<down>', '<C-w>j')
keymap.set('n', 's<up>', '<C-w>k')
keymap.set('n', 's<right>', '<C-w>l')

-- split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Cycle through splits.
keymap.set('n', '<S-Tab>', '<C-w>w')
keymap.set('n', '<Space>', '<C-w>w')

-- TABS
keymap.set('n', '<C-t>', ':tabnew<CR>')
keymap.set('n', 'tn', ':tabnew<CR>')
keymap.set('n', '<C-c>', ':bdelete<CR>')
-- keymap.set('n', 'gt', ':BufferLineCycleNext<CR>')
-- keymap.set('n', 'gT', ':BufferLineCyclePrev<CR>')

-- XXX experimental
keymap.set('i', '<C-t>', '<ESC>:tabnext<CR>i')
keymap.set('i', '<C-c>', '<ESC>:tabprevious<CR>i')

-- resize window (SHIFT + left/right/up/down)
keymap.set('n', '<S-left>', '<C-w><')
keymap.set('n', '<S-right>', '<C-w>>')
keymap.set('n', '<S-up>', '<C-w>+')
keymap.set('n', '<S-down>', '<C-w>-')

-- *****************************************************************************
-- }}}

-- SEARCH AND REPLACE {{{
-- *****************************************************************************

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
keymap.set('n', '<Leader>r', ':%s///g<Left><Left>')
keymap.set('n', '<Leader>rc', ':%s///gc<Left><Left><Left>')

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range. You can do that by
-- pressing *, visually selecting the range you want it to apply to and then
-- press a key below to replace all instances of it in the current selection.
keymap.set('x', '<Leader>r', ':s///g<Left><Left>')
keymap.set('x', '<Leader>rc', ':s///gc<Left><Left><Left>')

-- Type a replacement term and press . to repeat the replacement again. Useful
-- for replacing a few instances of the term (comparable to multiple cursors).
vim.cmd [[
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn
]]

-- Clear search highlights.
keymap.set('', '<Leader><Space>', ':let @/=\'\'<CR>')

-- *****************************************************************************
-- }}}

-- FUNCS {{{
-- *****************************************************************************

-- Toggle quickfix window.
vim.cmd [[
function! QuickFix_toggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    :execute "copen \| resize 2"
  else
    cclose
  endif
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>
]]

-- show syntax highlighting groups for word under cursor
-- use by pressing SHIFT+P
vim.cmd [[
nnoremap <S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
]]

-- *****************************************************************************
-- }}}

-- vim: set foldmethod=marker foldlevel=0:
