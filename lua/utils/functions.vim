function! MathAndLiquid()
    syn region math start=/\$\$/ end=/\$\$/
    syn match math_block '\$[^$].\{-}\$'
    syn match liquid '{%.*%}'
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    syn region highlight_block start='```' end='```'
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

function! SetNumber()
    if &number
        if &relativenumber
            setlocal nonumber
            setlocal norelativenumber
        else
            setlocal relativenumber
        endif
    else
        setlocal number
    endif
endfunction

function! ShowPaste()
    if &paste
        set showmode
    else
        set noshowmode
    endif
endfunction

function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

function ToggleCmp()
    if g:cmp_toggle==v:true
        let g:cmp_toggle=v:false
    else
        let g:cmp_toggle=v:true
    endif
endfunction

function! SetupOrgColors() abort
  hi link OrgAgendaScheduled HintMsg
  hi link OrgDONE DiffAdd
  hi link OrgTODO DiffDelete
endfunction
