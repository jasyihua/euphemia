from flask import render_template
from euphemiaweb import app


@app.route('/')
def index():
    # return 'Hello, I am Euphemia APP!'
    return render_template('index.html')
