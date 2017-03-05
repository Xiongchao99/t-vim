Plug 'lambdalisue/gina.vim'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'jaxbot/github-issues.vim', { 'on': 'Gissue' }
Plug 'rhysd/github-complete.vim'
Plug 'mhinz/vim-signify'

" Git releate ---------------------{{{
nnoremap <F3> :Gina status<cr>
" Open git status window
nnoremap <Leader>gs :Gina status<cr>
" Open github url
nnoremap <Leader>gh :Gina browse<cr>
" Open git log( browser mode)
nnoremap <Leader>gl :tabnew<cr>:Gina log --opener=vsplit<cr>
" Open git blame windows
nnoremap <Leader>gb :Gina blame :<cr>
" show branch
nnoremap <Leader>sb :Gina branch -a<cr>
" git diff current file (vimdiff)
nnoremap <Leader>gd :Gina compare :<cr>
" list git issue
nnoremap <Leader>gi :silent! Gissue<cr>
" create new github issue
nnoremap <Leader>ga :silent! Giadd<cr>
" git merge
nnoremap <Leader>gm :call te#git#git_merge()<cr>
let g:gissues_lazy_load = 1
let g:gissues_async_omni = 1
if filereadable($VIMFILES.'/.github_token')
    let g:github_access_token = readfile($VIMFILES.'/.github_token', '')[0]
endif
" git push origin master
nnoremap <Leader>gp :call te#git#GitPush("heads")<cr>
" git push to gerrit
nnoremap <Leader>gg :call te#git#GitPush("for")<cr>
" git fetch all
nnoremap <Leader>gf :call neomakemp#run_command('git fetch --all')<cr>
let g:signify_vcs_list = [ 'git', 'svn' ]
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

function s:gina_setting()
    call gina#custom#mapping#nmap(
                \ 'status', 'cc',
                \ ':<C-u>Gina commit<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ 'status', 'ca',
                \ ':<C-u>Gina commit --amend<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ 'commit', 'cc',
                \ ':<C-u>Gina status<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ 'status', '-',
                \ ':call gina#action#call(''index:toggle'')<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ 'status', 'U',
                \ ':call gina#action#call(''index:discard'')<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ 'status', 'D',
                \ ':call gina#action#call(''patch'')<CR>',
                \ {'noremap': 1, 'silent': 1},
                \)
    call gina#custom#mapping#nmap(
                \ '/.*', 'q',
                \ ':q<cr>',
                \ {'noremap': 1, 'silent': 1},
                \)
    let g:gina#command#status#use_default_mappings=0
	call gina#custom#mapping#nmap(
	      \ 'blame', 'j',
	      \ 'j<Plug>(gina-blame-echo)'
	      \)
	call gina#custom#mapping#nmap(
	      \ 'blame', 'k',
	      \ 'k<Plug>(gina-blame-echo)'
	      \)
endfunction

autocmd misc_group VimEnter * :call s:gina_setting()
"}}}
