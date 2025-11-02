" ~/.vim/scripts/duckquery.vim
" Führt SQL aus Register + gegen eine wählbare DuckDB-Datenbank aus.
" Ausgabe kann im Quickfix-Fenster oder im Register + erscheinen.

" Optional: alternativer Befehl (z.B. 'duckcli')
" let g:duck_cmd = 'duckcli'

command! -nargs=? DuckQueryQf  call s:DuckQueryToQuickfix(<f-args>)
command! -nargs=? DuckQueryReg call s:DuckQueryToRegister(<f-args>)

function! s:GetDuckCmd(dbfile)
    " Wähle CLI-Befehl
    if exists('g:duck_cmd') && !empty(g:duck_cmd)
        let l:cmd = g:duck_cmd
    else
        let l:cmd = 'duckdb'
    endif
    " Standarddatenbank ./master.db
    if empty(a:dbfile)
        let l:db = './master.db'
    else
        let l:db = a:dbfile
    endif
    return l:cmd . ' ' . shellescape(l:db)
endfunction

function! s:DuckQueryToQuickfix(...) abort
    let l:sql = getreg('+')
    let l:dbfile = a:0 > 0 ? a:1 : ''
    let l:out = systemlist(s:GetDuckCmd(l:dbfile), l:sql)
    call setqflist([], 'r', {'title': 'DuckDB ' . (empty(l:dbfile) ? './master.db' : l:dbfile), 'lines': l:out})
    copen
endfunction

function! s:DuckQueryToRegister(...) abort
    let l:sql = getreg('+')
    let l:dbfile = a:0 > 0 ? a:1 : ''
    let l:out = system(s:GetDuckCmd(l:dbfile), l:sql)
    let @+ = l:out
    echo "DuckDB-Ausgabe → Register + (" . (empty(l:dbfile) ? './master.db' : l:dbfile) . ")"
endfunction

" Komfort-Mappings:
" \dq: Absatz in + yanken, Query ausführen, Quickfix zeigen (Default-DB ./master.db)
nnoremap <leader>dq "+yip:DuckQueryQf<CR>
" \dr: Absatz in + yanken, Query ausführen, Ausgabe in Register + schreiben
nnoremap <leader>dr "+yip:DuckQueryReg<CR>
