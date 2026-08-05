#!/bin/bash
INPUT=$(cat)

codex exec --skip-git-repo-check \
"Du bist ein Tool zur Rechtschreibkorrektur.
Gib ausschließlich den korrigierten Text zurück.
Keine Erklärungen, keine zusätzlichen Worte.

$INPUT" 2>/dev/null