#!/usr/bin/env bash
# Lokalny podglad strony ARTEX.
# Odwzorowuje zachowanie Vercela: cleanUrls (/moda -> moda.html) i trailingSlash:false.
# Uzycie:  ./podglad.sh          (port 8000)
#          ./podglad.sh 9000     (inny port)
# Zatrzymanie: Ctrl+C

cd "$(dirname "$0")" || exit 1
PORT="${1:-8000}"

python3 - "$PORT" <<'PYTHON'
import http.server, os, socketserver, sys, threading, webbrowser

PORT = int(sys.argv[1])

class Handler(http.server.SimpleHTTPRequestHandler):
    def translate_path(self, path):
        # odetnij query i fragment
        clean = path.split('?', 1)[0].split('#', 1)[0].rstrip('/')
        if clean in ('', '/'):
            clean = '/index.html'
        local = os.path.join(os.getcwd(), clean.lstrip('/'))
        # cleanUrls: /moda -> moda.html
        if not os.path.exists(local) and os.path.exists(local + '.html'):
            local += '.html'
        return local

    def end_headers(self):
        # bez cache, zeby zmiany w plikach byly widoczne od razu po odswiezeniu
        self.send_header('Cache-Control', 'no-store, must-revalidate')
        super().end_headers()

    def send_error(self, code, message=None, explain=None):
        # jak na Vercelu: nieznany adres dostaje wlasna strone 404.html
        if code == 404 and os.path.exists('404.html'):
            tresc = open('404.html', 'rb').read()
            self.send_response(404)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.send_header('Content-Length', str(len(tresc)))
            self.end_headers()
            self.wfile.write(tresc)
            return
        super().send_error(code, message, explain)

    def log_message(self, fmt, *args):
        status = str(args[1]) if len(args) > 1 else ''
        mark = '  ' if status.startswith('2') else '!!'
        sys.stderr.write(f"{mark} {args[0]}  -> {status}\n")

socketserver.TCPServer.allow_reuse_address = True
try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        url = f"http://localhost:{PORT}/"
        print(f"\n  Podglad ARTEX dziala:  {url}")
        print(f"  Podstrony:             {url}moda   {url}soczewki")
        print( "  Zatrzymanie:           Ctrl+C\n")
        threading.Timer(0.8, lambda: webbrowser.open(url)).start()
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\n  Zatrzymano.\n")
except OSError as e:
    print(f"\n  Nie mozna uruchomic na porcie {PORT}: {e}")
    print(f"  Sprobuj innego portu, np.:  ./podglad.sh {PORT + 1}\n")
    sys.exit(1)
PYTHON
