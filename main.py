
import sys
from flask import Flask

app = Flask(__name__)

@app.route('/')
def root():
    return "hello"

@app.route('/setting')
def setting():
    return sys.argv[1]

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)