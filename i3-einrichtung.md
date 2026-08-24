# Meine i3-Einrichtung

Erstellt am 24. August 2026 auf Linux Mint 22.2.

## Ausgangslage

i3 war bereits installiert und lief als aktuelle X11-Sitzung. Installiert waren unter anderem:

- `i3` und `i3-wm` 4.23
- `i3status`
- `i3lock`
- `rofi`
- `dunst`
- `flameshot`
- `pasystray`
- `xfce4-clipman`
- `nm-applet` und `blueman-applet`
- `xfce4-terminal`

Die bestehende i3-Datei war noch fast vollständig die automatisch erzeugte Standardkonfiguration.

## Geänderte Dateien

Die Hauptkonfiguration befindet sich hier:

```text
~/.config/i3/config
```

Der Windows-ähnliche Fensterwechsler wird über dieses Hilfsskript gestartet:

```text
~/.config/i3/window-switcher.sh
```

Die rekursive Rofi-Dateisuche wird über dieses Skript gestartet:

```text
~/.config/i3/file-search.sh
```

Die kombinierte Rofi-Suche für Fenster, Programme und Befehle wird über dieses Skript gestartet:

```text
~/.config/i3/combi-search.sh
```

Die zentrierte und durchsuchbare Tastenkürzel-Hilfe wird aus dem Cheat Sheet dieser Dokumentation erzeugt:

```text
~/.config/i3/keybindings-help.sh
```

Für die Statusleiste wurde diese Datei angelegt:

```text
~/.config/i3status/config
```

Die ursprüngliche i3-Konfiguration wurde vorher gesichert:

```text
~/.config/i3/config.before-setup-2026-08-24
```

Auch die ursprüngliche systemweite i3status-Konfiguration wurde kopiert:

```text
~/.config/i3status/config.before-setup-2026-08-24
```

## Quellcode der Hilfsskripte

Die folgenden Codeblöcke entsprechen den aktuell verwendeten Skriptdateien.

### Fensterwechsler: `window-switcher.sh`

```sh
#!/bin/sh

exec rofi \
    -show window \
    -show-icons \
    -selected-row 1 \
    -kb-row-down 'Alt+Tab,Down' \
    -kb-row-up 'Alt+ISO_Left_Tab,Up' \
    -kb-accept-entry '!Alt_L,!Alt_R,Return'
```

### Rekursive Dateisuche: `file-search.sh`

```sh
#!/bin/sh

search_root=/home/mathias

# Search normal user directories recursively. Hidden directories, dependency
# trees and mounted/very large data locations are omitted to keep Rofi fast.
selected=$(
    find "$search_root" -mindepth 1 \
        \( -type d \( \
            -name '.*' -o \
            -name node_modules -o \
            -path "$search_root/mnt" -o \
            -path "$search_root/prod_mountpoint" -o \
            -path "$search_root/go/pkg" \
        \) -prune \) -o \
        -type f -printf '%P\n' 2>/dev/null |
        rofi -dmenu -i -p 'Datei suchen'
)

[ -n "$selected" ] || exit 0

selected_path="$search_root/$selected"
mime_type=$(file --brief --mime-type -- "$selected_path")

case "$mime_type" in
    text/*|application/json|application/xml|application/javascript|application/x-shellscript|application/x-empty)
        exec xfce4-terminal --disable-server --execute vim "$selected_path"
        ;;
    *)
        exec xdg-open "$selected_path"
        ;;
esac
```

### Kombinierte Suche: `combi-search.sh`

```sh
#!/bin/sh

exec rofi \
    -show combi \
    -modes combi \
    -combi-modes 'window,drun,run' \
    -show-icons \
    -display-combi 'Gesamtsuche'
```

### Tastenkürzel-Hilfe: `keybindings-help.sh`

```sh
#!/bin/sh

documentation=/home/mathias/go/projekt/vim_spicker/i3-einrichtung.md

awk -F '|' '
    /^## Cheat Sheet:/ { in_cheatsheet = 1; next }
    in_cheatsheet && /^## / { exit }
    in_cheatsheet && /^\| `/ {
        shortcut = $2
        description = $3
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", shortcut)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", description)
        gsub(/`/, "", shortcut)
        print shortcut "  —  " description
    }
' "$documentation" |
    rofi \
        -dmenu \
        -i \
        -no-custom \
        -location 0 \
        -p 'i3-Tastenkürzel' \
        -mesg 'Tippen zum Filtern · Esc zum Schließen' \
        -theme-str 'window { width: 760px; } listview { lines: 22; }' \
        >/dev/null
```

## Was eingerichtet wurde

### Bedienung

- Die Alt-Taste wird als i3-Mod-Taste verwendet.
- Fenster lassen sich mit `Alt + J/K/L` nach unten/oben/rechts fokussieren; für alle vier Richtungen stehen `Alt + Pfeiltasten` zur Verfügung.
- Mit zusätzlicher Umschalttaste werden Fenster verschoben.
- Es gibt zehn Arbeitsflächen, erreichbar über `Alt + 1` bis `Alt + 0`.
- Mit `Alt + Strg + Pfeiltaste` kann außerdem zur vorherigen oder nächsten Arbeitsfläche gewechselt werden.
- Ein Größenänderungsmodus wurde eingerichtet.
- Der i3-Scratchpad kann zum vorübergehenden Verstecken eines Fensters verwendet werden.

### Programme

- `Alt + Enter` öffnet das XFCE-Terminal.
- `Alt + D` öffnet eine kombinierte Rofi-Suche für offene Fenster, installierte Programme und ausführbare Befehle.
- `Alt + S` durchsucht mit Rofi rekursiv die normalen Ordner im persönlichen Verzeichnis. Versteckte Programm- und Cache-Ordner, Abhängigkeiten sowie große eingebundene Verzeichnisse werden für eine schnelle Suche ausgelassen. Erkannte Textdateien öffnen im Terminal mit Vim; andere Dateitypen mit ihrer Standardanwendung.
- `Alt + H` zeigt die aktuell dokumentierten Tastenkürzel in einem zentrierten, durchsuchbaren Rofi-Fenster an.
- `Alt + Tab` öffnet eine Übersicht aller offenen Fenster. Solange `Alt` gehalten wird, schaltet weiteres Drücken von `Tab` durch die Liste. Beim Loslassen von `Alt` wird das markierte Fenster in den Vordergrund geholt.
- Die Drucktaste startet die Bereichsauswahl von Flameshot.
- `Shift + Druck` kopiert einen Screenshot des gesamten Bildschirms in die Zwischenablage.

### Funktionsweise der rekursiven Dateisuche

Ursprünglich startete `Alt + S` den eingebauten Rofi-Dateibrowser. Dieser zeigte nur den jeweils geöffneten Ordner an. Die neue Belegung startet stattdessen das Skript:

```text
~/.config/i3/file-search.sh
```

Das Skript arbeitet in folgenden Schritten:

1. `find` durchsucht `/home/mathias` einschließlich der normalen Unterordner nach Dateien.
2. Die relativen Dateipfade werden an `rofi -dmenu` übergeben.
3. Rofi filtert die Liste während der Eingabe nach Datei- und Ordnernamen.
4. Nach der Auswahl ermittelt `file --mime-type` den Dateityp.
5. Erkannte Textdateien, JSON-, XML-, JavaScript- und Shell-Dateien werden mit Vim in einem neuen XFCE-Terminal geöffnet.
6. Alle anderen Dateitypen werden über `xdg-open` mit ihrer jeweiligen Standardanwendung geöffnet.

Der Vim-Aufruf entspricht dabei grundsätzlich:

```bash
xfce4-terminal --disable-server --execute vim DATEI
```

Andere Dateien werden grundsätzlich so geöffnet:

```bash
xdg-open DATEI
```

Damit die Dateiliste schnell aufgebaut wird und keine internen Programmdateien enthält, werden folgende Bereiche ausgelassen:

- versteckte Verzeichnisse, deren Name mit einem Punkt beginnt
- `node_modules`
- `/home/mathias/mnt`
- `/home/mathias/prod_mountpoint`
- `/home/mathias/go/pkg`

Versteckte Dateien direkt in `/home/mathias` können weiterhin gefunden werden; nur versteckte Verzeichnisbäume werden übersprungen.

### Zwischenablage

Die Einrichtung verwendet Xfce Clipman als schlanken X11-Zwischenablage-Manager. Clipman wird mit i3 gestartet und erscheint als Symbol im System-Tray der oberen i3-Leiste. Ein Klick auf das Symbol öffnet den Verlauf der kopierten Inhalte. `Alt + C` bleibt frei.

CopyQ wurde ausprobiert, danach aber wieder beendet und aus dem i3-Autostart sowie den Tastenkombinationen entfernt. Die CopyQ-Pakete können installiert bleiben, werden von dieser Konfiguration jedoch nicht gestartet oder benötigt.

### Lautstärkeregler im System-Tray

Pasystray wird zusammen mit i3 gestartet und zeigt ein Lautsprechersymbol im System-Tray der oberen Leiste. Die Lautstärke wird in Schritten von 5 Prozent geregelt.

Das ebenfalls installierte `xfce4-pulseaudio-plugin` wird nicht verwendet, weil es ein Plugin für das vollständige XFCE-Panel ist und nicht als eigenständiges Symbol im System-Tray von i3bar laufen kann. Dafür müsste zusätzlich `xfce4-panel` gestartet und anstelle von oder neben i3bar betrieben werden. Pasystray ist hier die schlankere Lösung, da es ohne XFCE-Panel direkt als Tray-Symbol funktioniert.

- Mausrad über dem Symbol: Lautstärke ändern
- Mittlere Maustaste oder `Alt + linke Maustaste`: Ausgabe stummschalten/aktivieren
- Klick auf das Symbol: Menü für Lautstärke, Ein-/Ausgabegeräte und laufende Audiostreams
- `Strg + Mausrad`: Mikrofonlautstärke ändern
- `Strg + mittlere Maustaste`: Mikrofon stummschalten/aktivieren

### Systemfunktionen

- Lauter, leiser, stumm und Mikrofon-stumm sind über die Sondertasten angebunden.
- `Alt + Shift + X` sperrt den Bildschirm mit `i3lock`.
- `xss-lock` sperrt den Bildschirm außerdem vor dem Energiesparmodus.
- NetworkManager, Bluetooth und Benachrichtigungen werden beim Start eingebunden.
- Pasystray stellt den Lautstärkeregler im System-Tray bereit.
- Xfce Clipman wird für den Zwischenablageverlauf im System-Tray gestartet.
- XDG-Autostart-Einträge werden über `dex` geladen.

### Darstellung

- Dunkles Farbschema mit blauen Akzenten.
- Schriftart `DejaVu Sans` in Größe 10.
- Kleine Abstände zwischen Fenstern.
- Zwei Pixel breite Fensterränder.
- Dialog- und Einstellungsfenster wie Pavucontrol und Blueman öffnen schwebend.
- Ein dunkelgrauer, einfarbiger Hintergrund wird mit `xsetroot` gesetzt.

### Statusleiste

Die Leiste befindet sich oben und zeigt:

- WLAN und Signalqualität
- freien SSD-Speicher
- verwendeten Arbeitsspeicher
- Akkustand und verbleibende Laufzeit
- Datum und Uhrzeit
- System-Tray für Netzwerk, Bluetooth, Zwischenablage und Lautstärke

## Cheat Sheet: Tastenkombinationen

`Alt` ist die Mod-Taste dieser i3-Konfiguration.

### Programme und Suche

| Tastenkombination | Funktion |
|---|---|
| `Alt + Enter` | XFCE-Terminal öffnen |
| `Alt + D` | Fenster, Programme und Befehle gemeinsam durchsuchen |
| `Alt + S` | Dateien rekursiv suchen; Textdateien mit Vim öffnen |
| `Alt + H` | Zentrierte, durchsuchbare Tastenkürzel-Hilfe anzeigen |
| `Alt + Tab` | Mit Rofi durch alle offenen Fenster wechseln |

### Fenster bedienen

| Tastenkombination | Funktion |
|---|---|
| `Alt + J/K/L` | Fokus nach unten/oben/rechts bewegen |
| `Alt + Pfeiltaste` | Fokus nach links/unten/oben/rechts bewegen |
| `Alt + Shift + H/J/K/L` | Aktuelles Fenster verschieben |
| `Alt + Shift + Pfeiltaste` | Aktuelles Fenster in Pfeilrichtung verschieben |
| `Alt + Q` | Aktuelles Fenster schließen |
| `Alt + F` | Vollbild ein-/ausschalten |
| `Alt + Shift + Leertaste` | Fenster zwischen schwebend und gekachelt umschalten |
| `Alt + Leertaste` | Fokus zwischen schwebenden und gekachelten Fenstern wechseln |
| `Alt + A` | Übergeordneten Fenstercontainer fokussieren |
| `Alt` + linke Maustaste | Schwebendes Fenster verschieben |

### Layout und Aufteilung

| Tastenkombination | Funktion |
|---|---|
| `Alt + B` | Nächsten Split horizontal anlegen |
| `Alt + V` | Nächsten Split vertikal anlegen |
| `Alt + T` | Aktuellen Split horizontal/vertikal drehen |
| `Alt + E` | Zwischen Stapelmodus und horizontaler Anordnung wechseln |
| `Alt + W` | Tab-Layout aktivieren |

### Workspaces

| Tastenkombination | Funktion |
|---|---|
| `Alt + 1…0` | Workspace 1 bis 10 öffnen |
| `Alt + Strg + Links/Hoch` | Zum vorherigen Workspace wechseln |
| `Alt + Strg + Rechts/Runter` | Zum nächsten Workspace wechseln |
| `Alt + Shift + 1…0` | Aktuelles Fenster auf Workspace 1 bis 10 verschieben |

### Größe ändern

| Tastenkombination | Funktion |
|---|---|
| `Alt + R` | Größenänderungsmodus starten |
| danach `H` oder `Links` | Fenster schmaler machen |
| danach `L` oder `Rechts` | Fenster breiter machen |
| danach `K` oder `Hoch` | Fenster niedriger machen |
| danach `J` oder `Runter` | Fenster höher machen |
| danach `Enter`, `Esc` oder `Alt + R` | Größenänderungsmodus beenden |

### Scratchpad

| Tastenkombination | Funktion |
|---|---|
| `Alt + Shift + -` | Fenster in den Scratchpad verschieben |
| `Alt + -` | Scratchpad-Fenster anzeigen oder verstecken |

### System und i3

| Tastenkombination | Funktion |
|---|---|
| `Alt + Shift + X` | Bildschirm sperren |
| `Alt + Shift + C` | i3-Konfiguration neu laden |
| `Alt + Shift + R` | i3 neu starten, ohne die Sitzung zu beenden |
| `Alt + Shift + E` | Von i3 abmelden |
| `Druck` | Screenshot-Bereich mit Flameshot auswählen |
| `Shift + Druck` | Gesamten Bildschirm in die Zwischenablage kopieren |
| Lautstärke hoch/runter | Lautstärke in 5-Prozent-Schritten ändern |
| Stummtaste | Tonausgabe stummschalten/aktivieren |
| Mikrofon-Stummtaste | Mikrofon stummschalten/aktivieren |

## Prüfung und Aktivierung

Die neue i3-Konfiguration wurde mit dem eingebauten Prüfmodus kontrolliert:

```bash
i3 -C -c ~/.config/i3/config
```

Danach wurde sie in der laufenden Sitzung geladen:

```bash
i3-msg reload
```

Auch die Statusleiste wurde testweise gestartet. WLAN, Speicher, RAM, Akku und Uhrzeit lieferten dabei gültige Werte.

## Optionale Programme

Die Pakete `brightnessctl`, `playerctl`, `picom` und `feh` wurden nicht installiert, weil in der verwendeten Sitzung kein interaktives Administratorpasswort eingegeben werden konnte. Sie sind für die jetzige Konfiguration nicht erforderlich.

Falls sie später gewünscht sind, können sie im Terminal installiert werden:

```bash
sudo apt install brightnessctl playerctl picom feh
```

Damit könnten anschließend zusätzliche Helligkeits- und Medientasten, Transparenz/Schatten sowie ein eigenes Hintergrundbild eingerichtet werden.

## Auf einem anderen Rechner mit Codex einrichten

Voraussetzung ist, dass Codex auf dem Zielrechner bereits installiert und einsatzbereit ist. Diese Datei wird Codex als Datei bereitgestellt oder in seinem Arbeitsverzeichnis abgelegt. Codex sollte die Konfiguration nicht blind kopieren, sondern zuerst Betriebssystem, vorhandene Programme, Bildschirmumgebung und bestehende Konfigurationsdateien prüfen.

Zusammen mit dieser Datei kann folgender Prompt vollständig an Codex übergeben werden:

```text
Lies die bereitgestellte Datei i3-einrichtung.md vollständig und richte die
darin beschriebene i3-Umgebung auf diesem Rechner ein.

Gehe dabei vorsichtig und rechnerabhängig vor:

1. Ermittle zuerst Distribution, Desktop-/X11-Sitzung, i3-Version, vorhandene
   Programme, Tastaturlayout, Monitore und bestehende i3-/i3status-Dateien.
2. Zeige mir kurz, was bereits vorhanden ist und welche Pakete noch fehlen.
3. Sichere vorhandene Konfigurationen, bevor du sie änderst. Überschreibe keine
   persönlichen Einstellungen oder fremden Dateien ohne Rückfrage.
4. Verwende diese Dokumentation als Zielbeschreibung, passe aber alle absoluten
   Pfade – insbesondere /home/mathias – an das tatsächliche Home-Verzeichnis und
   den tatsächlichen Speicherort dieses Repositorys an.
5. Installiere fehlende Pakete nur nach meiner Freigabe. Verwende die passenden
   Paketnamen und den Paketmanager der erkannten Distribution.
6. Erstelle die beschriebenen i3-, i3status- und Shell-Konfigurationen. Übernimm
   die dokumentierten Skripte, passe rechnerabhängige Pfade an und setze bei den
   Shell-Skripten das Ausführungsrecht.
7. Achte besonders darauf, dass keybindings-help.sh auf diese lokale Kopie von
   i3-einrichtung.md zeigt und dass keine Tastenkombination doppelt belegt ist.
8. Prüfe alle Shell-Skripte mit sh -n und die i3-Konfiguration mit i3 -C. Prüfe
   außerdem, ob alle referenzierten Befehle installiert und ausführbar sind.
9. Lade i3 erst nach erfolgreicher Validierung neu. Beende nicht eigenständig
   die grafische Sitzung und starte den Rechner nicht neu.
10. Fasse zum Schluss die Änderungen, Sicherungsdateien, Testergebnisse und noch
    offenen oder rechnerabhängigen Punkte zusammen.
```

### Wichtige Anpassungen auf dem Zielrechner

- `/home/mathias` muss durch das tatsächliche Home-Verzeichnis ersetzt werden.
- Der Pfad in `keybindings-help.sh` muss auf die lokale Kopie dieser Markdown-Datei zeigen.
- Terminal, Netzwerk-Applet, Bluetooth-Applet, Audio-System und Bildschirm-Sperre können je nach Distribution anders heißen.
- Die Konfiguration ist für i3 unter X11 erstellt; unter Wayland ist ein anderer Window Manager und teilweise andere Hilfssoftware erforderlich.
- Monitor-, Akku-, Netzwerk- und Helligkeitsgeräte müssen auf dem Zielrechner neu erkannt werden.
- Xfce Clipman und Pasystray sollen als Tray-Dienste gestartet werden; CopyQ ist nicht erforderlich und soll nicht automatisch starten.
- Vor dem Neuladen sollte Codex einen Git- oder Datei-Checkpoint anlegen, damit die Änderungen leicht rückgängig gemacht werden können.

## Alte Konfiguration wiederherstellen

Wenn die ursprüngliche Konfiguration wieder verwendet werden soll:

```bash
cp ~/.config/i3/config.before-setup-2026-08-24 ~/.config/i3/config
i3-msg reload
```
