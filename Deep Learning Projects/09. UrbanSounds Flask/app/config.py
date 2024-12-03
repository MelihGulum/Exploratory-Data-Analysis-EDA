import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config():
    # General Config
    SECRET_KEY = 'SECRET KEY'
    DEBUG = False
    TESTING = False

    # Static Assets
    STATIC_FOLDER = 'static'
    TEMPLATES_FOLDER = 'templates'


class ProductionConfig(Config):
    FLASK_ENV = 'production'

    # PostgreSQL database
    SQLALCHEMY_DATABASE_URI = '{}://{}:{}@{}:{}/{}'.format(
        os.getenv('DB_ENGINE'   , 'postgresql'),
        os.getenv('DB_USERNAME' , 'db_username'),
        os.getenv('DB_PASS'     , 'db_password'),
        os.getenv('DB_HOST'     , 'db_host'),
        os.getenv('DB_PORT'     , 5432),
        os.getenv('DB_NAME'     , 'test')
    )


class DevelopmentConfig(Config):
    FLASK_ENV = 'development'
    DEBUG = True

    # Flask-SQLAlchemy
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'db.sqlite3')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = True