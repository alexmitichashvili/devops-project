import os
from flask import Flask, jsonify, render_template, request

from app.logic import text_stats

app = Flask(__name__)
VERSION = os.getenv("APP_VERSION", "1.0.0")


@app.route("/")
def index():
    return render_template("index.html", version=VERSION)


@app.route("/health")
def health():
    return jsonify(status="ok", version=VERSION), 200


@app.route("/api/stats")
def stats():
    text = request.args.get("text", "")
    return jsonify(text_stats(text)), 200


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=int(os.getenv("PORT", 8000)))
