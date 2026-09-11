#!/bin/sh
# Erzeugt index.html (PWA-Version) aus snooker.html (Artifact-Version) und stempelt die Version in sw.js.
set -e
cd "$(dirname "$0")"
VERSION=$(date +%Y%m%d-%H%M%S)
{
  cat <<HEAD
<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0f1712">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Baize">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="icon" href="icon-192.png" type="image/png">
HEAD
  cat snooker.html
  cat <<TAIL
<script>
if ('serviceWorker' in navigator) navigator.serviceWorker.register('sw.js');
</script>
</body>
</html>
TAIL
} > index.html
# snooker.html beginnt mit <title>/<link>/<style> und dann <main>; head/body-Grenze setzen:
perl -0pi -e 's#</style>\n\n<main#</style>\n</head>\n<body>\n<main#' index.html
sed -E "s/^const VERSION = '[^']*';/const VERSION = '$VERSION';/" sw.js > sw.js.tmp && mv sw.js.tmp sw.js
echo "index.html gebaut, Service-Worker-Version $VERSION"
