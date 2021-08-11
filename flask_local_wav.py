from flask import Flask
from flask import Response
import base64
import urllib
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

@app.route('/<path_b64>', methods=["GET", "POST"])
def stream_mp3(path_b64):
    def generate():
        path = urllib.request.unquote(base64.urlsafe_b64decode(path_b64).decode('utf-8'))
        with open(path, 'rb') as fmp3:
            data = fmp3.read()
            return data

    return Response(generate(), mimetype="audio/wav")

if __name__ == '__main__':
    # app.run(debug=True)
    # so the other machine can visit the website by ip
    app.run(host='0.0.0.0')
