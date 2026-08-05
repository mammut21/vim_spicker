#!/bin/bash
set -euo pipefail

INPUT=$(cat)

codex exec --skip-git-repo-check --color never \
"Du bist ein Tool zur Überarbeitung von E-Mails.

Überarbeite den folgenden Text zu einer professionellen, klaren und gut formulierten E-Mail.

Achte dabei auf:
- korrekte Rechtschreibung und Grammatik
- einen sachlichen, professionellen Ton
- klare und verständliche Formulierungen
- sinnvolle Struktur (Absätze, ggf. Grußformel)

Erhalte die ursprüngliche Aussage und Sprache (Deutsch oder Englisch).

Gib ausschließlich die fertige, überarbeitete E-Mail zurück.
Keine Erklärungen, keine Kommentare, keine Hinweise.

Text:
$INPUT" 2>/dev/null