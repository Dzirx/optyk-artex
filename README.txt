ARTEX — strona salonu optycznego
================================

F.H.U. „Artex” Zakład Optyczny, Grunwaldzka 2, 33-200 Dąbrowa Tarnowska
Domena docelowa: optyk-artex.pl
Hosting: Vercel (deploy z repozytorium git)


STRUKTURA
---------
Statyczna strona w czystym HTML/CSS/JS — bez frameworka i bez procesu budowania.
Pliki idą na serwer takie, jakie są w repozytorium. Strony HTML muszą leżeć
w katalogu głównym, bo Vercel serwuje je stamtąd jako /moda, /soczewki itd.

  Strony
  index.html                strona główna (optyk, okulista, kontakt)
  badanie-wzroku.html       gabinet okulistyczny dr n. med. Witolda Tarkowskiego
  moda.html                 kolekcje modowe (Eva Minge, Armani, Vogue, Ray-Ban)
  soczewki.html             soczewki fotochromowe Transitions
  polityka-prywatnosci.html
  polityka-cookies.html
  404.html                  strona błędu (Vercel podłącza ją automatycznie)

  Zasoby strony
  css/style.css             wszystkie style + deklaracje @font-face
  js/main.js                FAQ, menu mobilne, przeciąganie kart i opinii,
                            baner cookies
  img/                      zdjęcia WebP, logo w pasku (logo-artex.webp),
                            ikona Google, obrazek do udostępniania (og-artex.jpg)
  fonts/                    Inter, Fraunces, Caveat hostowane lokalnie
  favicon.png, favicon.ico,
  apple-touch-icon.png      ikony z emblematu logo (wygenerowane z zrodla/logo.png)

  Konfiguracja
  vercel.json               czyste adresy (cleanUrls) + nagłówki cache
  robots.txt, sitemap.xml   dla wyszukiwarek
  .vercelignore             wyklucza z wdrożenia README, narzedzia/ i zrodla/

  Poza wdrożeniem
  narzedzia/podglad.sh      lokalny serwer podglądu
  narzedzia/sitemap.sh      generuje sitemap.xml z dat modyfikacji plików
  zrodla/                   oryginalne pliki od klienta (logo, zdjęcie salonu)
  README.txt                ten plik


PODGLĄD LOKALNY
---------------
  ./narzedzia/podglad.sh        uruchamia serwer na porcie 8000 i otwiera przeglądarkę
  ./narzedzia/podglad.sh 9000   inny port
  Ctrl+C                        zatrzymanie

WAŻNE: nie otwieraj plików przez dwuklik (file://). Linki między podstronami
prowadzą do adresów typu /moda i wymagają serwera. Skrypt odwzorowuje zachowanie
Vercela — czyste adresy, własna strona 404, brak cache — więc widzisz dokładnie
to, co pojawi się po wdrożeniu.

Przed każdym commitem ze zmianą treści:  ./narzedzia/sitemap.sh


ADRESY
------
Vercel ma włączone cleanUrls, więc podstrony działają bez końcówki .html:
  optyk-artex.pl/moda        (nie /moda.html)
Linki w kodzie muszą być pisane w tej formie — inaczej powstaje zbędne
przekierowanie przy każdym kliknięciu.


TREŚĆ — CO JEST PRAWDZIWE
-------------------------
Zdjęcia:  img/salon-optyczny.webp — prawdziwe wnętrze salonu (od klienta).
          img/badanie-wzroku.webp — wygenerowane; świadomie zostawione.
          img/okulista-artex.webp, img/oprawy-modowe.webp — nie pochodzą
          z salonu (grafika AI / zdjęcie z banku zdjęć).
Opinie:   prawdziwe, pochodzą z wizytówki Google tego zakładu.
          Uwaga: nie wolno oznaczać ich schematem AggregateRating — Google
          nie akceptuje dla lokalnej firmy ocen przeniesionych z innej
          platformy na własną stronę.
Dane firmowe, godziny, telefony i NIP: prawdziwe.

Polityki prywatności i cookies to szkice wymagające weryfikacji przez prawnika
lub specjalistę ds. RODO przed publikacją — zwłaszcza gdy na stronie pojawią się
formularze, analityka lub narzędzia reklamowe.


DANE STRUKTURALNE
-----------------
index.html zawiera schema.org: Optician (adres, geo, NIP, trzy telefony, godziny
salonu, gabinet okulistyczny dr n. med. Witolda Tarkowskiego jako osobny dział,
katalog usług), WebSite i FAQPage.
badanie-wzroku.html, moda.html i soczewki.html zawierają BreadcrumbList i FAQPage.
Odpowiedzi w FAQPage muszą być identyczne z widoczną sekcją FAQ na stronie.
Po każdej zmianie godzin, telefonów lub adresu trzeba zaktualizować też schemat.


FONTY
-----
Inter, Fraunces i Caveat są hostowane lokalnie (licencja SIL Open Font License),
obcięte do znaków łacińskich i polskich. Nie ma połączeń do serwerów Google —
dzięki temu adresy IP odwiedzających nie trafiają do Google i polityka
prywatności pozostaje zgodna ze stanem faktycznym.
Nie przywracaj ładowania fontów z fonts.googleapis.com bez aktualizacji polityki.


DO ZROBIENIA
------------
1. Połączyć gałąź seo-optymalizacja z main, żeby zmiany trafiły na produkcję.
2. Po podpięciu domeny: przekierowanie www → optyk-artex.pl w panelu Vercel
   (nie da się tego ustawić w vercel.json), następnie Google Search Console,
   wysłanie sitemapy i test na pagespeed.web.dev.
3. Weryfikacja polityk i banera cookies przez prawnika / specjalistę RODO
   (uwaga: osadzona mapa Google łączy się z serwerami Google).
4. Do potwierdzenia przez salon / lekarza: sekcja „Jak przygotować się do
   badania wzroku”, FAQ o soczewkach dla kierowców i Ray-Banach z korekcją,
   lista okolicznych gmin.
5. Do rozważenia: podstrona „Okulary korekcyjne” pod frazę lokalną.
6. Do rozważenia: krój Caveat waży 52 kB i obsługuje jeden cytat na dwóch
   stronach.
