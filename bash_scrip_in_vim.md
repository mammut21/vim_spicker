# 🧭 Vimscript-Spickzettel

**Thema:** Eigenes Vimscript als separate Datei speichern, laden und ausführen
**Beispiel:** `ls`-Ausgabe eines Verzeichnisses aus der Zwischenablage (`+`) entweder
→ im **Quickfix-Fenster** oder
→ direkt in ein **Register** schreiben

---

## 📁 1. Skript speichern

Erstelle eine Datei:

```bash
mkdir -p ~/.vim/scripts
vim ~/.vim/scripts/lsclipboard.vim
```

---

## 📜 2. Variante A – Ausgabe im Quickfix-Fenster

```vim
" ~/.vim/scripts/lsclipboard.vim
" Variante A: Ausgabe in Quickfix-Fenster
command! LsClipboard call s:LsClipboardToQuickfix()

function! s:LsClipboardToQuickfix()
    let l:path = getreg('+')
    let l:output = systemlist('ls -la ' . shellescape(l:path))
    call setqflist([], 'r', {'title': 'ls ' . l:path, 'lines': l:output})
    copen
endfunction
```

🔹 Ruft `ls -la` auf dem Pfad im Clipboard auf und zeigt das Ergebnis im Quickfix-Fenster an.

---

## 📜 3. Variante B – Ausgabe in ein Register schreiben

```vim
" Variante B: Ausgabe in Register +
command! LsClipboardReg call s:LsClipboardToRegister()

function! s:LsClipboardToRegister()
    let l:path = getreg('+')
    let l:output = system('ls -la ' . shellescape(l:path))
    let @+ = l:output
    echo "ls-Ausgabe gespeichert in Register +"
endfunction
```

🔹 Die Ausgabe landet direkt in der Zwischenablage (`@+`).
Du kannst sie danach mit `"+p` einfügen oder mit `:echo @+` anzeigen.

---

## ⚙️ 4. Skript einmalig laden

```vim
:source ~/.vim/scripts/lsclipboard.vim
```

---

## 🧱 5. Dauerhaft aktivieren

In `~/.vimrc`:

```vim
source ~/.vim/scripts/lsclipboard.vim
```

Oder automatisch:

```bash
mkdir -p ~/.vim/plugin
mv ~/.vim/scripts/lsclipboard.vim ~/.vim/plugin/
```

---

## 🧠 6. Verwendung

| Befehl            | Wirkung                                    |
| ----------------- | ------------------------------------------ |
| `:LsClipboard`    | Zeigt `ls -la`-Ausgabe im Quickfix         |
| `:LsClipboardReg` | Schreibt `ls -la`-Ausgabe ins Register `+` |
| `:echo @+`        | Zeigt Inhalt des Registers                 |
| `"+p`             | Fügt den Inhalt ein                        |

---

## 💡 7. Optionales Mapping

```vim
" Führt Variante B aus (in Register)
nnoremap <leader>l "+yip:LsClipboardReg<CR>
```

Dadurch genügt:

```
\l
```

→ Absatz kopieren, `ls` ausführen, Ausgabe in Register `+` speichern.

---

## 🔍 8. Zusammenfassung

| Ziel                 | Befehl / Vorgehen                                   |
| -------------------- | --------------------------------------------------- |
| Skript manuell laden | `:source ~/.vim/scripts/lsclipboard.vim`            |
| Dauerhaft aktivieren | `source ~/.vim/scripts/lsclipboard.vim` in `.vimrc` |
| Quickfix-Ausgabe     | `:LsClipboard`                                      |
| Register-Ausgabe     | `:LsClipboardReg`                                   |
| Inhalt anzeigen      | `:echo @+`                                          |
| Inhalt einfügen      | `"+p`                                               |

---

**Tipp:**
Für Neovim kannst du das Skript 1:1 übernehmen oder in `init.lua` übersetzen
(`vim.fn.systemlist()`, `vim.fn.setqflist()`, `vim.fn.setreg()`).

---
