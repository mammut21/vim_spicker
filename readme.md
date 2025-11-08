VIM - Schnellübersicht
----------
* `diffthis`  Zwei gesplittet Fenster vergleichen, per :diffthis in das einfenster dann  auch in das andere :diffthis dann wird nur diff angezeigt
* `STRG-r` 	Einfügen im Eingabe Modus aus einem beliebigen Buffer z.B + wenn man dann + noch drückt
* `STRG-W` 	Fenster wechseln mit Pfeiltasten,
  		oder wenn man das Terminal offen hat, kann man : eingeben und andere Befehle `STRG-r`
* `[<n>] GG`	wir springen zur Zeile n
* `gg`		Dateianfang
* `G`		Dateiende
* `:NERDTRee`	NERDTree starten ( Fileexplorer)
* `:terminal`	Neue Console
* `<ctrl>-n`	Autovervollständigung im Einfügemodus
* `<ctrl>-N`	Autovervollständigung im Einfügemodus alle offene Buffer
* `%s/^[\ \t]*\n//g`	Leerzeichen entfernen

Installation
------
`ln -s ~/go/projekt/vim_spicker/vimrc_basic  ~/.vimrc`

VIM - Einstellung ggf auch in die vimrc zu übernhmen
------

* `set smmatcase`	Wenn großbuchstaben verwendet werden, dann wird casesensetive gearbeitet
* `set ignorecase`	Bei der suche Groß und Klein nicht unterschieden
* `set whichwrap+=<,>,[,]`	Sorgt dafür das wenn man am anfang einer Zeile Steht un nach links drück am ende der vorherigen und umgekehrt springt
* `set mounse=a`	Schalten die Maus ein
* `:set nowrap`	Schalten den automatischen Zeilenumbruch aus

Bewegen in Dokument
--------------------
* `w,b,W,B` 	Wortweise hin und herbewegen anfang eines Worts
* `e`		Ende eines Worts
* `{[]}` 		Satzweise oder Abschnittsweise 
* `[<n>] GG`	wir springen zur zeile n
* `<ctrl>-e`	Abwärts Scrollen
* `<ctrl>-y`	Aufwärts Scrollen


Suchen und Ersetzen mit :/s
--------------------
* wenn man `:`/s eingibt kann man Text auch 
* `:%s/==.*//g` % bedeutet gesamtes dokument nicht nur die aktuelle Zeile
* 		/g heißt alle vorkommen und nicht nur das erste in der zeile
* `:%s/<suchetext>/<ersetzten>/g`
* `:%s/ \(Hallo \) /<ersetzten>/g` wenn du mit regex arbeiten möchtes und Gruppen verwendest dann müssen die maskiert werden \( 
*  
* `:s/abc/xyz/`	`abc` in aktueller Zeile durch `xyz` ersetzen
* `:%s/abc/xyz`	`abc` überall durch `xyz` ersetzen
* `:%s/<ctrl-r><ctrl-w>/xyz/g`	Wort unter Cursor überall durch `xyz` ersetzen
* `:%s/<ctrl-r>"/xyz/g`	Letzten geyankten Ausdruck überall durch `xyz` ersetzen
* `:s/ /\r/`	Leerstellen durch Zeilenumbruch ersetzen
* `%s/\(^[^ ]*\)/((a.\1=b.\1) or (a.\1 is null) and (b.\1 is null)) and /g`  der klassische join = or null spass

Suchen
--------------------
* `:nohlsearch`	löscht die Herforhebung nach suchen. reicht :noh<tap>
* `*`		sucht genau das Wort was aktuell unter dem Curser steht
* `/[Text]`	sucht nach dem nächsten vorkommen von [Text]
* `/[Text]/+1/[Text2]` sucht nach einer Zeile mit Text1 und das in der nächsten Zeile Text2 steht.
* `n`		weiter suchen
* `N`		vorher suchen 
* `[I`		Suchtrefferliste anzeigen (großes I
* `ggn`		um zum ersten Spiel zu springen, oder
* `GN`		um zum letzten zu springen.
* `let @/ = @1`	kopiert den Inhalt des Registers 1 zum such register, damm kann man mit `/` und  `ENTER` nach dem Text aus der Zwischenablage suchen.
* `STRG-r` 	Text Einfügen im `:`Kommandozeile,  dazu muss nach dem `STRG-r` noch das Register angegeben werden + für normal Zwischeanblage.
* 


Makros aufzeichen
--------------------
* `q[t]	`	beginnt mit der Aufzeichung eines makros für den unter `t` eingegeben Buchstaben anschliesend q drücken benendet das makro aufzeichenen
* ```
  :tabnew
  :NERDTree
  ENDE
  ```
  Diese Makro erstellt einen neuen Tab mit NERDTree am rand, kopieren kannst du das mit `0"[register]y/ENDE`
  Dabei ist 0 Zeilen Anfang , " Heißt register ansteuer , / suchen dann ENDE alles in das Register kopieren


Umgang mit Tab
--------------------
* `t`		in NERDTree öffene die gewählten Datei in einem Neuen Tab
* `gt`		wechselt zum nächsten Tab
* `gT`		wechselt zum vorherigen Tab

Terminal
--------------------
* `STRG-w N`  	(großens N, damit kann man im :terminal modus unschalten das man den Text kopieren kann)
* `i`		kommt man wieder zurück in den terminal modus

Buffer:
-------
* `:ls `	zeigt alle offenen Buffer an
* `:b <n>` 	öffnet Buffer n
* `:bd` 	heißt buffer delete -> schließt den aktuellen buffer oder mit <n> und ! denn n-ent unter Zang.
* `:bn`		Nächster Buffer
* `:bp`		Vorheriger Buffer
* `:b#`		Wechsle zum zuletzt geöffneten Buffer
* `:b <N>`	Direkt zum Buffer mit Nummer
* `:b <text>`	Wechsle per Namenssuche


Fenster:
-------
* `:split`		Aktuelles Fenster teilen
* `:vsplit`		Aktuelles Fenster vertikal teilen
* `:split <file>`	<file> in neuem Fenster öffnen
* `:new`		Neuen Buffer in neuem Fenster öffnen
* `:sview <file>`	:split und :view <file>
* `C-w w`	Nächstes Fenster selektieren (zyklisch)
* `C-w j`		Ein Fenster nach unten
* `C-w k`		Ein Fenster nach oben
* `<n>C-w +`	Fenster um <n> Zeilen vergrößern
* `<n>C-w -`	Fenster um <n> Zeilen verkleinern
* `<n>C-w <`	Fenster um <n> Zeichen verbreitern
* `<n>C-w >`	Fenster um <n> Zeichen verschmalen
* `<n>C-w _`	Fenstergröße auf <n> Zeilen setzen (ohne <n>: maximal)
* `C-w =`	Alle Fenster gleichgroß
* `:sp datei`	Bildschirm teilen und datei in neuem Fenster anzeigen:

Sitzung:
-------
* `:mks!`	Aktuelle Session inkl. aller Buffer und Fenster speichern
* `vi -S`	Vim mit gespeicherter Session startn

Register
--------------------
Die Register sind zwischenablagen welche man durch :registers auflisten kann
bei der Verwendung von d oder dd wird in die register 1- 9 nach und nach die Daten geschrieben, die gelöscht wurden.
mit " kann man auf ein register zugreifen, in `"+` ist die akuelle systemweite Zwischenablagen, mit `"+p` kannst du da was rein kopieren oder raus holen. 

Folds
--------------------

* `set foldmethode=indent` 	schaltet Fold ein und zwar nach Pythonart (einrückung)
* `zf` 	Fold aus markiertem Bereich erstellen
* `za` 	Aktuellen Fold welchsel (von auf zu zu und umgekehrt)
* `zA` 	Aktuellen Fold welchsel und alle Unterfolds mit öffen (von auf zu zu und umgekehrt)
* `zd` 	Aktuellen Fold löschen
* `zR` 	Alle Folds öffnen
* `zM` 	Alle Folds schliessen
* `zo` 	Fold unter Cursor öffnen
* `zc` 	Fold unter Cursor schliessen

Rezepte
------------------

Mehere Zeilen Auskommentieren 
------------------
* `STRG-v`  (visual Blockmodus) umschalten
* dann den Bereich markieren der auskommentiet werden soll
*  dann (großes `I` für Anfang der Zeile oder `A` für aktuelle pos des Cursers)
*  dann # oder // oder einen beliebigen Text eingeben, (Wichtig: es wird scheinbar nur die erste Zeile bearbeite, nach ESC werden die änderungen auch auf den markierten zeile angewand)
*   achdem du ESC gedrück hast beendet sich das ganze.


Suchen und Finden wie in Nodepad++
--------------------
Wenn du suchen willst wie bei Notepag++ "Alles Finden" dann mach folgendes
* `:vim /Suchbegriff/ % <enter>`
* 	% steht für den aktuellen Buffer alternativ
** 	kann man auch **/*
** 	oder **/*.py für rekursives suchen
** 	oder *.py für nur in dem Verzeichnis
** 	oder  /home/mathias/*.txt für eine konkretes Verzeichnis 
* `:copen`  	-> copen öffent den Quickfix Buffer in dem dann alle Suchergebnisse drin stehen 
* `:cclose`	Schließtm am den QuickEditor wieder
vingrep kann auch reguläre ausdrücke und man kann statt % eine datei pfad angeben /home/mathias/ * .txt dann durchsucht es die datei anstatt des aktuellen buffers

Navigation <motion> 
-------------------
h,l,j,k		Cursor links, rechts, runter, rauf
:b 		Bufferauswahl (geöffnete Datei, mit ls kannst also :b leerzeichen dann TAB drücken)
w		Nächster Wortanfang
W		Nächster WORD-Anfang (durch Blank abgegrenzt)
e		Nächstes Wortende
E		Nächstes WORD-Ende
b		Vorheriger Wortanfang
B		Vorheriger WORD-Anfang
ge		Vorheriges Wortende
0		Zeilenanfang
^		Erstes Zeichen der Zeile
$		Zeilenende
)		Nächster Satzanfang
(		Vorheriger Satzanfang
}		Nächstes Absatzende
{		Vorheriger Absatzanfang
+		Erstes Zeichen der nächsten Zeile
-		Erstes Zeichen der vorherigen Zeile
%		Zugehörige Klammer
gg		Dateianfang
G		Dateiende
<n>G oder gg	Zteile <n>
H		Erste Bildschirmzeile
M		Bildschirmmitte
L		Letzte Bildschirmzeile
C-f		Bildschirmseite runter
C-b		Bildschirmseite hoch
C-d		Halbe Bildschirmseite runter
C-u		Halbe Bildschirmseite hoch
[<n>]zt		aktuelle Zeile auf Bildschirmzeile <n> scrollen
[<n>]zb		aktuelle Zeile auf <n>t-lezte Bildschirmzeile scrollen
zz		aktuelle Zeile auf Bildschirmmitte scrollen


Textobjekt-Selektion für Befehle <selection>
--------------------------------------------
<motion> oder: a|i w|W|s|p|(|)|b|[|]|<|>|{|}|B

a		Äußeres Objekt (inkl. Klammern, etc.)
i		Inneres Objekt (ohne Klammern und Leerraum)

w		Wort
W		WORD
s		Satz
p		Absatz
( ) b		() - Klammerblock
[ ]		[] - Klammerblock
< >		<> - Klammerblock
{ } B		{} - Klammerblock

Textselektion im Visual mode
----------------------------
v		zeichenorientiert
V		zeilenorientiert
C-v		rechteckorientiert


Suche
-----
/<string>	Vorwärtssuche nach <string>
?<string>	Rückwärtssuche nach <string>
n		nächster Treffer in gleicher Richtung
N		nächster Treffer in anderer Richtung
:nohlsearch    löscht die markierung an wenn du was gesucht hast
Bereiche
--------
<range> ::=   %			(ganze Datei)
	    | <line s>,<line e>	(von Zeile s bis Zeile e)
	    | <line s>;<line n>	(n Zeilen ab Zeile s

<line> ::=    n			(Zeile Nummer n)
	   |  .			(aktuelle Zeile)
	   |  $			Letzte Zeile in Datei
	   |  /pattern		Nächste Zeile, in der string vorkommt

Wechsel in Eingabemodus
-----------------------
i		Text vor der aktuellen Position einfügen
I		Text am Zeilenanfang (erstes Nicht-Blank) einfügen
a		Text nach der aktuellen Position einfügen
A		Text am Ende der aktuellen Zeile einfügen
R		Text ab aktueller Position überschreiben
o		Neue Zeile nach der aktuellen erzeugen
O		Neue Zeile vor der aktuellen erzeugen
s		Aktuelles Zeichen löschen, dann insert
S		Aktuelle Zeile löschen, dann insert

Tasten im Eingabemodus
----------------------

C-w		letztes Wort löschen
C-p		Wort vervollständigen
C-t		Zeile einrücken
C-d		Zeile Ausrücken
ESC		Eingabemodus verlassen

Befehle
-------
[count]command			command count-mal ausführen (default: 1)
u				Letzten Befehl rückgängig machen
U				Undo der aktuellen Zeile
x				Zeichen unter Cursor löschen
X				Zeichen vor Cursor löschen
d<selection>			Löschen bis zur Position <motion>
dd				Aktuelle Zeile löschen
D				Von Cursor bis zum Zeilenende löschen
y<selection>			Kopieren in Default-Puffer bis <motion>
yy				Kopieren der aktuellen Zeile
c<selection>			Ersetzen (Löschen und Eingabe) bis <motion>
cc				Aktuelle Zeile ersetzen
C				Vom Cursor bis zum Zeilenende ersetzen
p				Default-Puffer nach Cursor einfügen (von d oder y)
P				Default-Puffer vor Cursor einfügen
.				Wiederholung des letzten d oder c
J				Verbindet die aktuelle mit der nächsten Zeile
r<char>				Ersetzt das aktuelle Zeichen durch <char>
~				Ändert Groß/Kleinschreibung des akt. Zeichens
q<char> <commands> q		Makro namens <char> aufzeichnen
@<char>				Makro namens <char> aufrufen

:[range] s/from/to/[g][c]	in range (default: aktuelle Zeile) erstes from
				durch to ersetzen; g=alle Vorkommen ersetzen;
				c=mit Bestätigung

:[range] g[!]/pattern/command	in range (default: ges. Datei) command in Zeilen
				ausführen, die pattern (! = nicht) erfüllen 

!<motion> <system command>	Filtern bis <motion> durch <system command>

Textfaltung
-----------
zf<selection>			Faltung erzeugen
zo				Faltung öffnen
zc				Faltung schließen
zr				sichtbare Faltungstiefe erhöhen
zR				alle Faltungen sichtbar machen
zm				sichtbare Faltungstiefe verringern
zM				alle Faltungen einklappen
zn				Faltungsmodus ausschalten
zN				Faltungsmodus einschalten
zi				Faltungsmodus umschalten
:set foldmethod			Methode setzen (indent, marker, syntax)

Markierungen
------------
m<char>				Setzt Markierung namens <char>
'<char>				Springt zur Markierung <char>
:marks				Zeigt alle Markierungen an

Dateikommandos
--------------

:q		Beenden
:q!		Beenden ohne Speichern
:x	ZZ	Speichern und Beenden
:w		Speichern



" =============================================================================
" Vim Cheat Sheet – Wichtige Tastenkombinationen und Befehle
" =============================================================================

" ---------------------------
" Grundlagen: Modi und Navigation
" ---------------------------
" Wechsel in den Einfügemodus:
"   - i    : Einfügemodus an der Cursorposition starten.
"   - I    : Einfügemodus am Zeilenanfang starten.
"   - a    : Einfügemodus nach dem Cursor starten.
"   - A    : Einfügemodus am Zeilenende starten.
"
" Zurück in den Normalmodus:
"   - <Esc>
"
" Navigation im Normalmodus:
"   - h, j, k, l   : Cursor links, runter, hoch, rechts bewegen.
"   - w            : Zum Anfang des nächsten Wortes springen.
"   - b            : Zum Anfang des vorherigen Wortes springen.
"   - 0 (Null)     : Zum Zeilenanfang springen.
"   - $            : Zum Zeilenende springen.

" ---------------------------
" Bearbeiten und Löschen
" ---------------------------
"   - dd       : Löscht die aktuelle Zeile.
"   - yy       : Kopiert (yankt) die aktuelle Zeile.
"   - p        : Fügt den kopierten Text nach dem Cursor ein.
"   - u        : Macht die letzte Änderung rückgängig.
"   - Ctrl+r   : Wiederholt den Rückgängig-Befehl (Redo).

" ---------------------------
" Suchen und Ersetzen
" ---------------------------
" Suchen:
"   - /Suchbegriff : Sucht vorwärts nach dem Begriff (unter Beachtung von 
"                    'ignorecase' und 'smartcase').
"   - ?Suchbegriff : Sucht rückwärts.
"   - n            : Zum nächsten Treffer springen.
"   - N            : Zum vorherigen Treffer springen.
"
" Ersetzen:
"   - :%s/alt/neu/g : Ersetzt im gesamten Dokument alle Vorkommen von 'alt' mit 'neu'.

" ---------------------------
" Fenster (Splits) und Tabs
" ---------------------------
" Fenster:
"   - :split           : Öffnet ein neues horizontal geteiltes Fenster.
"   - :vsplit          : Öffnet ein neues vertikal geteiltes Fenster.
"   - Ctrl+w, w       : Wechsel zwischen geteilten Fenstern.
"   - Ctrl+w, q       : Schließt das aktuelle Fenster.
"
" Tabs:
"   - :tabnew [Datei]   : Öffnet einen neuen Tab (optional mit einer Datei).
"   - :tabnext         : Wechselt zum nächsten Tab.
"   - Beispiel Mapping (F3): Wechselt mit der F3-Taste zum nächsten Tab.
"         nnoremap <F3> :tabnext<CR>

" ---------------------------
" Buffer Management
" ---------------------------
" Buffer-Liste anzeigen:
"   - :ls oder :buffers
" Buffer wechseln:
"   - :bnext (oder :bn)  : Nächsten Buffer öffnen.
"   - :bprev (oder :bp)  : Vorherigen Buffer öffnen.
"   - Beispiel Mapping (F5): Wechselt mit der F5-Taste zum nächsten Buffer.
"         nnoremap <F5> :bnext<CR>

" ---------------------------
" Spezielle Mappings (Leader-Key)
" ---------------------------
" <leader> ist ein benutzerdefinierter Präfix (Standard: "\"), der zur 
" Gruppierung eigener Tastenkombinationen genutzt wird.
" Beispiel: Um den Leader-Key zu ändern, füge in Deiner vimrc hinzu:
"         let mapleader = ","
"
" Beispiele:
"   - Fuzzy Finder (z.B. CtrlP, LeaderF oder Telescope):
"         nnoremap <leader>f :CtrlP<CR>
"         (öffnet den Fuzzy Finder, standardmäßig z.B. "\f")
"
"   - Undo-Baum (Undotree):
"         nnoremap <leader>u :UndotreeToggle<CR>
"         (öffnet oder schließt den Undo-Baum, standardmäßig "\u")
"
"   - vimrc neu laden:
"         nnoremap <leader>sv :source $MYVIMRC<CR>
"         (lädt die vimrc neu, z.B. "\sv")

" ---------------------------
" Diff und Änderungen anzeigen
" ---------------------------
" Unterschiede zwischen der aktuellen und der letzten gespeicherten Version anzeigen:
"   - :vert diffsplit % 
"     (öffnet eine vertikale Diff-Ansicht; schließe den Split, um wieder zurückzukehren)

" ---------------------------
" Suchen in mehreren Dateien (vimgrep)
" ---------------------------
" Um in allen Dateien, die einem bestimmten Muster entsprechen, nach einem
" Suchbegriff zu suchen, kannst Du vimgrep verwenden.
"
" Beispiel: Suche nach 'Suchbegriff' in allen Dateien mit der Endung .xxx im
" aktuellen Verzeichnis (rekursiv):
"         :vimgrep /Suchbegriff/ **/*.xxx
"
" Anschließend kannst Du die Quickfix-Liste mit
"         :copen
" öffnen, um alle Treffer anzuzeigen und mit n/N oder den Pfeiltasten durch
" die Ergebnisse zu navigieren.
" 
" ---------------------------
" Funktionstasten (F-Tasten) Übersicht
" ---------------------------
"   - F3: Zum Wechseln des nächsten Tabs
"         nnoremap <F3> :tabnext<CR>
"   - F4: Zum Wechseln zwischen geteilten Fenstern
"         nnoremap <F4> <C-w>w
"   - F5: Zum Wechseln des nächsten Buffers
"         nnoremap <F5> :bnext<CR>

" ---------------------------
" Beenden und Speichern
" ---------------------------
" Speichern:
"   - :w      : Speichert die aktuelle Datei.
"   - :wq oder :x : Speichert und beendet Vim.
"
" Beenden:
"   - :qa     : Schließt alle Buffer und beendet Vim.
"   - :qa!    : Erzwingt das Beenden, auch wenn ungespeicherte Änderungen vorliegen.
"
" Weitere nützliche Befehle:
"   - :e!     : Lädt die aktuelle Datei neu und verwirft alle Änderungen.
"   - :PluginInstall  : Installiert alle Plugins (bei Verwendung von Vundle).
" =============================================================================


