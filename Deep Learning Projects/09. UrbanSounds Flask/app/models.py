from datetime import datetime
from . import db


class Post(db.Model):
    __tablename__ = 'Post'
    id = db.Column(db.Integer, primary_key=True)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    firstname = db.Column(db.String(20), nullable=False)
    lastname = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(120), nullable=False)
    phone = db.Column(db.String(20), nullable=False)
    message = db.Column(db.Text, nullable=False)

    def __init__(self, date_posted, firstname, lastname, email, phone, message):
        self.date_posted = date_posted
        self.firstname   = firstname
        self.lastname = lastname
        self.email      = email
        self.phone = phone
        self.message = message

    def __repr__(self):
        return str(self.id) + ' - ' + str(self.firstname) +" "+ str(self.lastname)

    def save(self):

        # inject self into db session
        db.session.add ( self )

        # commit change and save the object
        db.session.commit( )
        return self

class Error(db.Model):
    __tablename__ = 'Error'
    id = db.Column(db.Integer, primary_key=True)
    time = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    error = db.Column(db.String(50), nullable=False)
    url = db.Column(db.String(50), nullable=False)

    def __init__(self, time, error, url):
        self.time = time
        self.error   = error
        self.url = url

    def save(self):
        db.session.add ( self )
        db.session.commit( )
        return self