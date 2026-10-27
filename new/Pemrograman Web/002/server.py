#!/usr/bin/env python3
"""Tiny stdlib backend: serves index.html/form.html + stores form to SQLite."""
import sqlite3
import urllib.parse
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

BASE = Path(__file__).parent
DB = BASE / "database.db"

SCHEMA = """
CREATE TABLE IF NOT EXISTS mahasiswa (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nama TEXT,
  password TEXT,
  id_mahasiswa INTEGER,
  tanggal TEXT,
  jk TEXT,
  hobi TEXT,
  organisasi TEXT,
  alamat TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"""

def get_db():
    conn = sqlite3.connect(DB)
    conn.execute(SCHEMA)
    return conn

MIME = {".html": "text/html", ".css": "text/css", ".js": "text/javascript", ".mp4": "video/mp4", ".webm": "video/webm"}

class Handler(BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass  # quiet; comment out for debug

    def serve_file(self, name):
        f = BASE / name.lstrip("/") if name != "/" else BASE / "index.html"
        if f.is_dir():
            f = f / "index.html"
        if not f.exists() or not f.is_file():
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b"Not found")
            return
        self.send_response(200)
        self.send_header("Content-Type", MIME.get(f.suffix, "text/plain") + "; charset=utf-8")
        self.end_headers()
        self.wfile.write(f.read_bytes())

    def do_GET(self):
        if self.path == "/data":
            conn = get_db()
            rows = conn.execute("SELECT id, nama, id_mahasiswa, tanggal, jk, hobi, organisasi, alamat, created_at FROM mahasiswa ORDER BY id DESC").fetchall()
            conn.close()
            body = "<h1>Data tersimpan</h1><p><a href='/'>Kembali</a></p><table border=1 cellpadding=8><tr><th>ID</th><th>Nama</th><th>ID Mhs</th><th>Tanggal</th><th>JK</th><th>Hobi</th><th>Organisasi</th><th>Alamat</th><th>Waktu</th></tr>"
            for r in rows:
                body += "<tr>" + "".join(f"<td>{(c or '')}</td>" for c in r) + "</tr>"
            body += "</table>"
            data = body.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        self.serve_file(urllib.parse.urlparse(self.path).path)

    def do_POST(self):
        if urllib.parse.urlparse(self.path).path != "/submit":
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b"Unknown POST target")
            return
        length = int(self.headers.get("Content-Length", 0))
        fields = urllib.parse.parse_qs(self.rfile.read(length).decode(), keep_blank_values=True)
        get = lambda k: fields.get(k, [""])[0].strip()
        hobi = ",".join(v for v in fields.get("hobi", []) if v)
        row = (get("nama"), get("password"),
               int(get("id_mahasiswa")) if get("id_mahasiswa").lstrip("-").isdigit() else None,
               get("tanggal") or None, get("jk"), hobi, get("organisasi"), get("alamat"))
        conn = get_db()
        conn.execute("INSERT INTO mahasiswa (nama, password, id_mahasiswa, tanggal, jk, hobi, organisasi, alamat) VALUES (?,?,?,?,?,?,?,?)", row)
        conn.commit()
        conn.close()
        self.send_response(303)
        self.send_header("Location", "/data")
        self.end_headers()

if __name__ == "__main__":
    import sys
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8001
    get_db().close()
    print(f"DB: {DB}")
    print(f"Serving on http://localhost:{port}")
    HTTPServer(("0.0.0.0", port), Handler).serve_forever()
