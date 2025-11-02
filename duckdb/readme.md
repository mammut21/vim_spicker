## Achtung KI generiert noch nicht gestest

Super, hier ist die **erweiterte Version** als vollständige Vimscript-Datei.
Neu dabei: zwei Befehle, die **den aktuellen Buffer** (oder **nur eine visuelle Auswahl**) als SQL an DuckDB schicken:

* `:DuckFileQf [dbfile]` → Ausgabe ins **Quickfix-Fenster**
* `:DuckFileReg [dbfile]` → Ausgabe ins **Register `+`**

Zusätzlich bleiben die Befehle erhalten, die den **Absatz aus `"+yip`** verwenden:

* `:DuckQueryQf [dbfile]`
* `:DuckQueryReg [dbfile]`

> Standard-DB ist `./master.db`. Du kannst optional eine andere DB-Datei als Argument angeben.
> Optional: `let g:duck_cmd = 'duckcli'` für andere CLI.

---

### `~/.vim/scripts/duckquery.vim`

```vim
" ~/.vim/scripts/duckquery.vim
" SQL gegen DuckDB ausführen – wahlweise:
"  A) Query aus Zwischenablage (+) → :DuckQueryQf / :DuckQueryReg
"  B) Query aus Buffer/Range        → :DuckFileQf  / :DuckFileReg
"
" Default-DB: ./master.db (anpassbar über Argument oder g:duck_default_db)
" Optionaler alternativer CLI-Befehl: g:duck_cmd (Standard: 'duckdb')

" let g:duck_cmd = 'duckcli'              " Optional: anderer Befehl
" let g:duck_default_db = './silver.db'   " Optional: andere Standard-DB

" ----------------------------
" User Commands (mit optionaler DB)
" ----------------------------
command! -nargs=? DuckQueryQf  call s:DuckQueryToQuickfix(<f-args>)
command! -nargs=? DuckQueryReg call s:DuckQueryToRegister(<f-args>)

" -range=%: standardmäßig ganzer Buffer; mit visueller Auswahl wird nur Range übergeben
command! -nargs=? -range=% DuckFileQf  call s:DuckFileToQuickfix(<line1>, <line2>, <f-args>)
command! -nargs=? -range=% DuckFileReg call s:DuckFileToRegister(<line1>, <line2>, <f-args>)

" ----------------------------
" Helpers
" ----------------------------
function! s#GetDefaultDb() abort
  if exists('g:duck_default_db') && !empty(g:duck_default_db)
    return g:duck_default_db
  endif
  return './master.db'
endfunction

function! s#GetDuckCmd(dbfile) abort
  let l:cmd = (exists('g:duck_cmd') && !empty(g:duck_cmd)) ? g:duck_cmd : 'duckdb'
  let l:db  = empty(a:dbfile) ? s:GetDefaultDb() : a:dbfile
  return l:cmd . ' ' . shellescape(l:db)
endfunction

function! s#SqlFromRange(first, last) abort
  " Hole Zeilenbereich und verbinde mit Newlines (füge am Ende einen Newline hinzu)
  let l:lines = getline(a:first, a:last)
  return join(l:lines, "\n") . "\n"
endfunction

" ----------------------------
" Variante A: Query aus Zwischenablage (+)
" ----------------------------
function! s#DuckQueryToQuickfix(...) abort
  let l:sql    = getreg('+')
  let l:dbfile = a:0 > 0 ? a:1 : ''
  let l:out    = systemlist(s:GetDuckCmd(l:dbfile), l:sql)
  let l:title  = 'DuckDB ' . (empty(l:dbfile) ? s:GetDefaultDb() : a:1)
  call setqflist([], 'r', {'title': l:title, 'lines': l:out})
  copen
endfunction

function! s#DuckQueryToRegister(...) abort
  let l:sql    = getreg('+')
  let l:dbfile = a:0 > 0 ? a:1 : ''
  let l:out    = system(s:GetDuckCmd(l:dbfile), l:sql)
  let @+ = l:out
  echo "DuckDB-Ausgabe → Register + (" . (empty(l:dbfile) ? s:GetDefaultDb() : a:1) . ")"
endfunction

" ----------------------------
" Variante B: Query aus Buffer/Range
" ----------------------------
function! s#DuckFileToQuickfix(first, last, ...) abort
  let l:sql    = s:SqlFromRange(a:first, a:last)
  let l:dbfile = a:0 > 0 ? a:1 : ''
  let l:out    = systemlist(s:GetDuckCmd(l:dbfile), l:sql)
  let l:label  = bufname('%')
  if empty(l:label) | let l:label = '[No Name]' | endif
  let l:title  = printf('DuckDB %s — %s:%d-%d', (empty(l:dbfile) ? s:GetDefaultDb() : a:1), l:label, a:first, a:last)
  call setqflist([], 'r', {'title': l:title, 'lines': l:out})
  copen
endfunction

function! s#DuckFileToRegister(first, last, ...) abort
  let l:sql    = s:SqlFromRange(a:first, a:last)
  let l:dbfile = a:0 > 0 ? a:1 : ''
  let l:out    = system(s:GetDuckCmd(l:dbfile), l:sql)
  let @+ = l:out
  echo "DuckDB-Ausgabe → Register + (" . (empty(l:dbfile) ? s:GetDefaultDb() : a:1) . ")"
endfunction

" ----------------------------
" Komfort-Mappings
" ----------------------------
" Absatz → + yanken → Quickfix/Register (Standard-DB)
nnoremap <leader>dQ "+yip:DuckQueryQf<CR>
nnoremap <leader>dR "+yip:DuckQueryReg<CR>

" Ganzer Buffer oder visuelle Auswahl → Quickfix/Register (Standard-DB)
" Normal Mode: ganze Datei
nnoremap <leader>dF :DuckFileQf<CR>
nnoremap <leader>dG :DuckFileReg<CR>
" Visual Mode: nur Auswahl
vnoremap <leader>dF :'<,'>DuckFileQf<CR>
vnoremap <leader>dG :'<,'>DuckFileReg<CR>
```

---

### Einbinden & Nutzen

1. Datei speichern und laden

```vim
:source ~/.vim/scripts/duckquery.vim
```

oder dauerhaft in `~/.vimrc`:

```vim
source ~/.vim/scripts/duckquery.vim
```

2. **Absatz → Query**

* Quickfix: `\dQ`
* Register: `\dR`

3. **Datei/Range → Query**

* **Ganzer Buffer** an DB → Quickfix: `\dF`
* **Ganzer Buffer** an DB → Register: `\dG`
* **Visuelle Auswahl** markieren, dann `\dF` oder `\dG`

4. **Andere DB kurz angeben**

```vim
:DuckFileQf ./andere.db
:DuckQueryReg ~/data/test.db
```

5. **Optional** (Neovim/andere CLI)

```vim
:let g:duck_cmd = 'duckcli'
:let g:duck_default_db = './silver/agg.db'
```

Wenn du magst, kann ich dir noch eine kleine **Fehlermeldungs-Erkennung** einbauen, die bei DuckDB-Fehlern das Quickfix passend markiert (z. B. Zeilennummern aus Parse-Fehlern herauszieht).
