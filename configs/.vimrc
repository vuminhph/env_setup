" turn hybrid line numbers on
:set number relativenumber
:set nu rnu


"tab stop
:set tabstop=4


" Wilder Menu 
call plug#begin()
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  " Required for vim 8
  Plug 'roxma/vim-hug-neovim-rpc'
  " Install this plugin
  Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }

endif
call plug#end()

" Default keys
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })

" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))
