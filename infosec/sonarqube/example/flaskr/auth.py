import functools
import sys

from flask import Blueprint
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import session
from flask import url_for
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

from flaskr.db import get_db

bp = Blueprint("auth", __name__, url_prefix="/auth")


def login_required(view):
    """View decorator that redirects anonymous users to the login page."""

    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for("auth.login"))

        return view(**kwargs)

    return wrapped_view


@bp.before_app_request
def load_logged_in_user():
    """If a user id is stored in the session, load the user object from
    the database into ``g.user``."""
    #user_id = session.get("user_id")
    user_id = ""
    
    oidc_user = request.headers['OIDC-USER']
    oidc_email = request.headers['OIDC-EMAIL']
    oidc_name = request.headers['OIDC-NAME']
    #oidc_preferred_username = request.headers['x-oidc-preferred-username']
    
    
    print(" ------------------------OIDC      USER:      {}    ".format(oidc_name), file=sys.stderr)
    
    
    #Override userid with userid from header
    if oidc_name is not None:
        user_id = oidc_name;


    if user_id is None:
        g.user = None
    else:
        ex_db = get_db()
        g.user = (
            ex_db.execute("SELECT * FROM user WHERE username = ?", (user_id,)).fetchone()
        )
        
        print(" --------------------------   ", file=sys.stderr)
        print(" -------------FINAL----------------      USER:      {}    ".format(user_id), file=sys.stderr)
        print(" --------------------------   ", file=sys.stderr)
        
        # This might happen first time when okta user is not registered locally
        if g.user is None and user_id is not None:
            username = oidc_name
            password = oidc_email
            
            # the name is available, store it in the database and go to
            # the login page
            ex_db.execute(
                "INSERT INTO user (username, password) VALUES (?, ?)",
                (username, generate_password_hash(password)),
            )
            ex_db.commit()
            


@bp.route("/register", methods=("GET", "POST"))
def register():
    """Register a new user.

    Validates that the username is not already taken. Hashes the
    password for security.
    """
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        ex_db = get_db()
        error = None

        if not username:
            error = "Username is required."
        elif not password:
            error = "Password is required."
        elif (
            ex_db.execute("SELECT id FROM user WHERE username = ?", (username,)).fetchone()
            is not None
        ):
            error = "User {0} is already registered.".format(username)

        if error is None:
            # the name is available, store it in the database and go to
            # the login page
            ex_db.execute(
                "INSERT INTO user (username, password) VALUES (?, ?)",
                (username, generate_password_hash(password)),
            )
            ex_db.commit()
            return redirect(url_for("auth.login"))

        flash(error)

    return render_template("auth/register.html")


@bp.route("/login", methods=("GET", "POST"))
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        ex_db = get_db()
        error = None
        user = ex_db.execute(
            "SELECT * FROM user WHERE username = ?", (username,)
        ).fetchone()

        if user is None:
            error = "Incorrect username."
        elif not check_password_hash(user["password"], password):
            error = "Incorrect password."

        if error is None:
            # store the user id in a new session and return to the index
            #session.clear()
            #session["user_id"] = user["id"]
            return redirect(url_for("index"))

        flash(error)

    return render_template("auth/login.html")


@bp.route("/logout")
def logout():
    """Clear the current session, including the stored user id."""
    #session.clear()
    return redirect(url_for("index"))
