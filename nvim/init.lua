-- set global leader key
vim.g.mapleader = ","
-- -- Give everything possible a border (diagnostics, hover, ...)
vim.o.winborder = 'single'

require('pack')
require('basic')
require('netrw')
require('maps')
require('color')

-- GENERAL
--
-- CTRL+n opens file browser (netrw)

-- NEOVIM LSP DEFAULTS

-- GLOBAL DEFAULTS
--
-- help lsp-defaults
-- https://neovim.io/doc/user/lsp.html#_global-defaults
--
-- gra gri grn grr grt i_CTRL-S v_an v_in These GLOBAL keymaps are created unconditionally when Nvim starts:
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
-- "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()

-- BUFFER-LOCAL DEFAULTS
--
-- help lsp-defaults
-- https://neovim.io/doc/user/lsp.html#_buffer-local-defaults
--
-- 'omnifunc' is set to vim.lsp.omnifunc(), use i_CTRL-X_CTRL-O to trigger completion.
-- 'tagfunc' is set to vim.lsp.tagfunc(). This enables features like go-to-definition, :tjump, and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server.
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
-- To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
-- K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
-- Document colors are enabled for highlighting color references in a document.
-- To opt out call vim.lsp.document_color.enable(false, args.buf) on LspAttach.

-- COMPLETION
--
-- help lsp-completion
-- https://neovim.io/doc/user/lsp.html#lsp-completion
--
-- Use CTRL-Y to select an item from the completion menu. complete_CTRL-Y

-- DIAGNOSTICS
--
-- help diagnostic-defaults
-- https://neovim.io/doc/user/diagnostic.html#diagnostic-defaults
--
-- These diagnostic keymaps are created unconditionally when Nvim starts:
-- ]d jumps to the next diagnostic in the buffer. ]d-default
-- [d jumps to the previous diagnostic in the buffer. [d-default
-- ]D jumps to the last diagnostic in the buffer. ]D-default
-- [D jumps to the first diagnostic in the buffer. [D-default
-- <C-w>d shows diagnostic at cursor in a floating window. CTRL-W_d-default

-- TELESCOPE
--
-- CTRL+u - Scroll up
-- CTRL+d - Scroll down
