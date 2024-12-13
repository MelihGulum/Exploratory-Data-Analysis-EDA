from flask import Flask
import redis

app = Flask(__name__)
redis_client = redis.StrictRedis(host="redis", port=6379, decode_responses=True)

@app.route("/")
def home():
    count = redis_client.incr("hits")
    return f"Welcome! This page has been viewed {count} times."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
