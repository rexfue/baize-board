# Baize Board

Snooker-Scoreboard als PWA: Punkte pro versenkter Kugel, Restwert, Fouls, Free Ball, Undo, Frame-Zählung.

- `snooker.html` – Quelle (Seiteninhalt ohne `<html>`/`<head>`-Rahmen, so auch als Claude-Artifact veröffentlicht)
- `build.sh` – erzeugt daraus `index.html` (PWA mit Manifest, Icons, Service Worker) und stempelt die Version in `sw.js`
- Nach Änderungen an `snooker.html`: `./build.sh`, dann committen und pushen – GitHub Pages liefert die neue Version aus.
