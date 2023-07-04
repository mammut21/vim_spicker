# VIM - Befehle und Tastatenbelegung 
* `STRG-W` 	Fenster wechseln mit Pfeiltasten, oder wenn man das Terminal offen hat kann man : eingeben und andere Befehle
* `[<n>] GG`	wir springen zur zeile n
* `:NERDTRee`	NERDTree starten ( Fileexplorer)
* `:terminal`	Neue Console

Bewegen in Dokument
--------------------
* `w,b,W,B` 	Wortweise hin und herbewegen anfang eines Worts
* `e`		Ende eines Worts
* `{[]}` 		Satzweise oder Abschnittsweise 
* `[<n>] GG`	wir springen zur zeile n

Suchen und Ersetzen
--------------------
* `:nohlsearch`	löscht die herforhebung nach suchen. reicht :noh<tap>
* `*`		sucht genau das Wort was aktuell unter dem Curser steht
* `/[Text]`		sucht nach dem nächsten vorkommen von [Text] 
* `n`		weiter suchen
* `N`		vorher suchen 
* `[I`		Suchtrefferliste anzeigen (großes I
* `ggn`		um zum ersten Spiel zu springen, oder
* `GN`		um zum letzten zu springen.

Makros aufzeichen
--------------------
* `q[t]	`	beginnt mit der Aufzeichung eines makros anschliesend q drücken benendet das makro aufzeichenen
* ```
  :tabnew
  NERDTree
  ENDE
  ``` 
`
* `:tabnew :NERDTree ENDE`  	Diese Makro erstellt einen neuen Tab mit NERDTree am rand, kopieren kannst du das mit `0"[register]y/ENDE`


Umgang mit Tab
--------------------
* `t`		in NERDTree öffene die gewählten Datei in einem Neuen Tab
* `gt`		wechselt den Tab

Terminal
--------------------
* `STRG-w N`  	(großens N, damit kann man im :terminal modus unschalten das man den Text kopieren kann)
* `i`		kommt man wieder zurück in den terminal modus

Buffer:
-------
* `:ls `	zeigt alle offenen Buffer an
* `:b <n>` 	öffnet Buffer n
* `:bd` 	heißt buffer delete -> schließt den aktuellen buffer oder mit <n> und ! denn n-ent unter Zang.

Register
--------------------
Die Register sind zwischenablagen welche man durch :registers auflisten kann
bei der Verwendung von d oder dd wird in die register 1- 9 nach und nach die Daten geschrieben, die gelöscht wurden.
mit " kann man auf ein register zugreifen, in `"+` ist die akuelle systemweite Zwischenablagen, mit `"+p` kannst du da was rein kopieren oder raus holen. 


Rezepte
------------------

Mehere Zeilen Auskommentieren 
------------------
STRG-v (visual Blockmodus) dann (großes I für Anfang der Zeile oder A für aktuelle pos des Cursers) dann kannst du einfang eine Kommentierung machen, nachdem du ESC gedrück hast beendet sich das ganze.


Suchen und Finden wie in Nodepad++
--------------------
Wenn du suchen willst wie bei Notepag++ "Alles Finden" dann mach folgendes
* `:vimgrep /Suchbegriff/ % <enter>` 	% steht für den aktuellen Buffer
* `:copen`  	-> copen öffent den Quickfix Buffer in dem dann alle Suchergebnisse drin stehen 

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

Fenster
-------
:split		Aktuelles Fenster teilen
:split <file>	<file> in neuem Fenster öffnen
:new		Neuen Buffer in neuem Fenster öffnen
:sview <file>	:split und :view <file>

C-w w		Nächstes Fenster selektieren (zyklisch)
C-w j		Ein Fenster nach unten
C-w k		Ein Fenster nach oben
<n>C-w +	Fenster um <n> Zeilen vergrößern
<n>C-w -	Fenster um <n> Zeilen verkleinern
<n>C-w _	Fenstergröße auf <n> Zeilen setzen (ohne <n>: maximal)
C-w =		Alle Fenster gleichgroß

