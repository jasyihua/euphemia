from flask import Flask
app = Flask(__name__)

import euphemiaweb.views

if __name__ == "__main__":
    app.run(debug=False)
