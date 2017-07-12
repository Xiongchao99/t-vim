Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'Raimondi/delimitMate'
Plug 'thinca/vim-qfreplace',{'on': 'Qfreplace'}
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' "repeat enhance
Plug 'junegunn/vim-easy-align',{'on': [ '<Plug>(EasyAlign)', '<Plug>(LiveEasyAlign)' ]}
if !te#env#IsNvim()
    Plug 'osyo-manga/vim-over',{'on': 'OverCommandLine'}
    Plug 'tracyone/vim-easyclip'
endif
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'mbbill/undotree',  { 'on': 'UndotreeToggle'   }
Plug 'tweekmonster/spellrotate.vim', {'on': ['<Plug>(SpellRotateForward)']}
Plug 'ZSaberLv0/VimIM'
Plug 'tracyone/VimIM_db'
Plug 'ZSaberLv0/VimIMSync'
let g:vimim_cloud = 'google,sogou,baidu,qq'  
let g:vimim_map = 'tab_as_gi' 
nmap <silent> <leader>zn <Plug>(SpellRotateForward)
nmap <silent> <leader>zp <Plug>(SpellRotateBackward)
vmap <silent> <leader>zn <Plug>(SpellRotateForwardV)
vmap <silent> <leader>zp <Plug>(SpellRotateBackwardV)
nmap <leader>tz :call te#utils#OptionToggle('spell', [1,0])<cr>

" DelimitMate ---------------------{{{
let g:delimitMate_nesting_quotes = ['"','`']
let g:delimitMate_expand_cr = 0
let g:delimitMate_expand_space = 0
"}}}
" Algin ---------------------------{{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
xmap <leader>al <Plug>(LiveEasyAlign)
" Live easy align
nmap <leader>al <Plug>(LiveEasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
" }}}
" Incsearch -----------------------{{{
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)
" }}}
" Nerdcommander -------------------{{{
let g:NERDMenuMode=0
let g:NERD_c_alt_style=1
"toggle comment
nmap <Leader>;; <plug>NERDCommenterComment
nmap <Leader>cc <plug>NERDCommenterComment
"}}}
"replace
if !te#env#IsNvim()
    nnoremap <c-h> :OverCommandLine<cr>:%s/<C-R>=expand("<cword>")<cr>/
    vnoremap <c-h> :OverCommandLine<cr>:<c-u>%s/<C-R>=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]<cr>/
else
    nnoremap <c-h> :%s/<C-R>=expand("<cword>")<cr>/
    vnoremap <c-h> :<c-u>%s/<C-R>=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]<cr>/
endif
" undo tree window toggle
nnoremap <leader>tu :UndotreeToggle<cr>
" easyclip ------------------------{{{
nnoremap <c-y> :Yanks<cr>
imap <c-y> <c-[>:Yanks<cr>
" Open yankring window
nnoremap <Leader>yy :Yanks<cr>
" clear yank history
nnoremap <Leader>yc :ClearYanks<cr>
let g:EasyClipShareYanks=1
let g:EasyClipShareYanksDirectory=$VIMFILES
let g:EasyClipUseYankDefaults=1
let g:EasyClipUseCutDefaults=0
let g:EasyClipUsePasteDefaults=0
let g:EasyClipEnableBlackHoleRedirect=0
let g:EasyClipUsePasteToggleDefaults=0
let g:EasyClipCopyExplicitRegisterToDefault=1
nmap <silent> gs <plug>SubstituteOverMotionMap 
nmap gss <plug>SubstituteLine
xmap gs <plug>XEasyClipPaste
call te#meta#map('nmap ','p','<plug>EasyClipSwapPasteForward')
call te#meta#map('nmap ','n','<plug>EasyClipSwapPasteBackwards')
"}}}
"
let g:Vimim_map='no-gi'
let g:Vimim_punctuation=0
let g:Vimim_toggle='pinyin,baidu'
let g:VimIMSync_repo_head='https://'
let g:VimIMSync_repo_tail='github.com/tracyone/VimIM_db'
let g:VimIMSync_user='tracyone'
let g:VimIMSync_file='plugin/vimim.baidu.txt'
command! -nargs=0 IMView execute 'edit '.g:t_vim_plugin_install_path.'VimIM_db/'.g:VimIMSync_file
function! s:vimim_add_word()
    let l:word=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]
    let l:pinyin=input("Please input pinyin for ".l:word.': ')
    execute ':IMAdd '.l:word.' '.l:pinyin
endfunction
function! s:vimim_upload()
    execute 'cd '.g:t_vim_plugin_install_path.'/VimIM_db'
    let l:command='git fetch --all && git stash && git rebase origin/master && git stash pop && git add . && git commit -m "Upload ..." && git push origin master'
    call te#utils#run_command(l:command)
endfunction
vnoremap <silent> ;; :call <SID>vimim_add_word()<cr>
nnoremap <silent> <Leader>vu :call <SID>vimim_upload()<cr>

"inoremap <silent> ;; <C-R>=g:Vimim_chinese()<CR>
"nnoremap <silent> ;: i<C-R>=g:Vimim_onekey()<CR><Esc>l
"inoremap <silent> ;: <C-R>=g:Vimim_onekey()<CR>

" vim: set fdm=marker foldlevel=0 foldmarker& filetype=vim: 
