#!/usr/bin/env bash
# Generuje sitemap.xml z faktycznych dat modyfikacji plikow.
# Uruchom po zmianie tresci, PRZED commitem:  ./sitemap.sh
#
# lastmod bierze date ostatniej zmiany pliku, wiec nie trzeba jej pamietac.
# Do sitemapy wchodza tylko adresy indeksowalne — 404.html jest pominiety
# swiadomie, bo ma noindex.

cd "$(dirname "$0")" || exit 1
DOMENA="https://optyk-artex.pl"

# plik:adres:priorytet
STRONY=(
  "index.html:/:1.0"
  "badanie-wzroku.html:/badanie-wzroku:0.9"
  "moda.html:/moda:0.8"
  "soczewki.html:/soczewki:0.8"
  "polityka-prywatnosci.html:/polityka-prywatnosci:0.2"
  "polityka-cookies.html:/polityka-cookies:0.2"
)

{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  for wpis in "${STRONY[@]}"; do
    IFS=':' read -r plik adres priorytet <<< "$wpis"
    [ -f "$plik" ] || { echo "  UWAGA: brak $plik — pomijam" >&2; continue; }
    # noindex nie ma prawa trafic do sitemapy
    if grep -q 'name="robots" content="noindex' "$plik"; then
      echo "  UWAGA: $plik ma noindex — pomijam" >&2
      continue
    fi
    echo "  <url>"
    echo "    <loc>${DOMENA}${adres}</loc>"
    echo "    <lastmod>$(date -r "$plik" +%F)</lastmod>"
    echo "    <priority>${priorytet}</priority>"
    echo "  </url>"
  done
  echo '</urlset>'
} > sitemap.xml

echo "sitemap.xml przegenerowany ($(grep -c '<url>' sitemap.xml) adresow)"
