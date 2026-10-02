from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import os

PORT = int(os.getenv("PORT", "8080"))

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body = json.dumps({"status": "healthy", "application": "Axion"}).encode()
            self.send_response(200)
        elif self.path == "/":
            body = b"Axion application is running"
            self.send_response(200)
        else:
            body = b"Not Found"
            self.send_response(404)
        self.send_header("Content-Type", "application/json" if self.path == "/health" else "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print(fmt % args, flush=True)

ThreadingHTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
