from euphemiaweb import app


@app.route('/')
def index():
    return 'Hello, I am Euphemia APP!'
