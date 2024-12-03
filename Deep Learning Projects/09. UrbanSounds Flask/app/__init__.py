from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from .config import *
from .views import views

db = SQLAlchemy()

def register_extensions(app):
    db.init_app(app)

def configure_database(app):

    @app.before_first_request
    def initialize_database():
        db.create_all()

    @app.teardown_request
    def shutdown_session(exception=None):
        db.session.remove()

def app():
    app = Flask(__name__)
    app.config.from_object(DevelopmentConfig)

    app.register_blueprint(views, url_prefix="/")

    from .models import Post, Error
    register_extensions(app)
    configure_database(app)
    return app