from flask import Flask, request, render_template_string

app = Flask(__name__)

@app.route("/")
def index():
    return "<h1> welcome to nandeesh's python app! </h1>"

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method ==  "POST":
        user = request.form.get("username")
        return f"<h2>hello, {user}!</h2>"
    return render_template_string("""
       <form method = "POST">
           <input type="text" name="username" placeholder="Enterusername/">
           <input type="submit" value="login"/>
       </form>
    """)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


