## Achtung KI generiert noch nicht gestest

Ja, absolut ✅ — das ist eine saubere Erweiterung!
Wir bauen das Skript so um, dass du **die Datenbankdatei flexibel angeben** kannst, z. B.:

* Standard bleibt `./master.db`
* Du kannst aber beim Aufruf eine andere angeben:

  ```vim
  :DuckQueryQf mydata.db
  :DuckQueryReg ~/daten/verkehr.db
  ```

Und die Mappings (`\dq` / `\dr`) verwenden automatisch die Standard-DB.

---

## 🧩 Neue Version: `duckquery.vim` (mit variabler Datenbank)

```vim
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
```

---

## 🧠 Nutzung

### 1️⃣ Standard (Datenbank `./master.db`)

```
\dq     → Absatz kopieren + ausführen → Quickfix
\dr     → Absatz kopieren + ausführen → Register +
```

oder manuell:

```vim
:DuckQueryQf
:DuckQueryReg
```

---

### 2️⃣ Eigene Datenbank angeben

```vim
:DuckQueryQf ./daten/linie_2025.db
:DuckQueryReg ~/duckdata/test.db
```

---

### 3️⃣ Quickfix navigieren

| Befehl    | Beschreibung              |
| --------- | ------------------------- |
| `:copen`  | Quickfix-Fenster öffnen   |
| `:cclose` | schließen                 |
| `:cc 2`   | 2. Ergebniszeile anzeigen |

---

### 💡 Optional: Datenbank-Wechsel per Variable

Wenn du z. B. oft dieselbe DB nutzt, kannst du in Vim kurz setzen:

```vim
:let g:duck_default_db = './silver/agg.db'
```

und in der Funktion (oben) einfach austauschen:

```vim
if exists('g:duck_default_db')
    let l:db = g:duck_default_db
else
    let l:db = './master.db'
endif
```

---

Möchtest du, dass ich noch eine dritte Variante einbaue, die die **aktuell geöffnete Datei** (z. B. eine `.sql`-Datei) als Query verwendet statt den Absatz (`yip`)? Das wäre ideal, wenn du größere SQL-Skripte testweise ausführen willst.
