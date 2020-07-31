from flask import Flask           # import flask
app = Flask(__name__)             # create an app instance

@app.route("/")                   # at the end point /
def hello():                      # call method hello
    return "And Back To Green Again!"         # which returns "hello world"

if __name__ == "__main__":        # on running python app.py
    app.run(port=80)    